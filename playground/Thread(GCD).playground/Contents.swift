import UIKit
import Foundation

// 참고: https://babbab2.tistory.com/64?category=831129


// MARK: - sync
print("\n\n=============== sync ===============\n\n")
// sync: 단일 작업에 대해 내가 보낸 응답을 받을 때 까지 기다림, 내 작업이 끝나야 다음 작업을 수행한다. ex) 우리가 보통 써내려 가는 코드가 sync임 위에서 수행한 작업이 종료되기 전에 다음 코드가 실행되지 않음!!

// 예시
//print("시작")
//sleep(3)
//print("sync 작업")

// MARK: - async
print("\n\n=============== async ===============\n\n")
// async: 단일 작업에 대해 내가 보낸 응담을 받을 때 까지 기다리지 않음(!), 내 작업이 끝나기 전에 다음 작업 수행 가능. ex) URLSession 통신 요청, callback을 받기 전까지 다른 작업을 수행 할 수 있다.

// 예시
//print("시작")
//DispatchQueue.global().async {
//	sleep(3)
//}
//print("async 작업")

// MARK: - serial
print("\n\n=============== serial ===============\n\n")
// serial queue: 내 Queue에 들어온 작업들을 순차적으로 실행 시킨다. 따라서 작업을 동기화 시키고 싶을 때 사용한다.(🌟 핵심) 큐안에서 하나의 작업이 끝나야 다음 작업을 수행함 ex) main, DispatchQueue(label: "name")

// "Main Thread"
// iOS에서 Main Thread는 오직 한 개만 존재한다. 우리가 평소에 아무렇지 않게 작성하는 코드들이 바로 이 Main Thread에서 동작하는 것인데,
// 이 작성된 코드가 Cocoa에서 실행될 때, Main Thread에서 호출하기 때문임!!
// 또 Main Thread의 중요한 것 중 하나는, 이 Main Thread는 Interface Thread라고도 불리는데,
// 그 이유는 UI와 관련된 작업은 모두 이 Main Thread에 붙기 때문에, UI와 관련된 작업은 반드시 Main Thread에서 작성해야 함!!

// 11111(sync)
//		-> 22222(async)
//				-> 33333(sync)

// 예시
//let serialQueue = DispatchQueue(label: "serial")
//
//serialQueue.async {
//	sleep(2)
//	print("A")
//}
//print("B")
//
//DispatchQueue.global().async {
//	sleep(2)
//	print("A")
//}
//print("B")
//
//func asyncFunc() {
//	print("func start")
//	DispatchQueue.global().async {
//		sleep(3)
//	}
//	print("func end")
//}
//
//
//print("start")	// serial queue, sync
//DispatchQueue.main.async {	// serial queue, async
//	asyncFunc()
//}
//DispatchQueue.main.async {
//	for _ in 0...10 {
//		print("async") // (#2) 이 작업을 시작 할 수 있다.
//	}
//}
//for _ in 0...10 {	// serial queue, sync
//	print("sync")	// (#1) 따라서 이 작업 + 아래 작업들이 전부 끝나야
//}
//print("before sleep")	// serial queue, sync
//sleep(3)
//print("after sleep")
//
//DispatchQueue.main.async {
//	sleep(3)
//	print("async after sleep")
//}

// MARK: - concurrent
print("\n\n=============== concurrent ===============\n\n")
// concurrent queue: 내 Queue에 들어온 작업들을 동시다발적으로 실행 시킨다. 한번에 동시에 작업을 수행함(🌟 하지만 수행 순서는 들어온 순서대로) ex) global, DispatchQueue(label: "name", attributes: .concurrent)

// "Global Thread"
// iOS에서의 Framework들은 모두 Background에서 구동이 된다.
// 몸체는 Background에 있지만, 가끔 필요할 때 Main Thread에게 손(Delegate, completion handler)을 뻗는 구조

// 11111
//-> 22222
//	-> 33333

// 예시
//let concurrentQueue = DispatchQueue.init(label: "concurrent queue", attributes: .concurrent)
//concurrentQueue.sync  { print("start") }	// (#1) sync 인 start가 먼저 찍힘
//concurrentQueue.async { for _ in 0...5 { print("async") }}	// (#2) 그 다음 sync 와 async print 함수들이 동시에 수행된다 (concurrent 큐 안에 있기 때문에)
//concurrentQueue.sync  { for _ in 0...5 { print("sync") } }
//concurrentQueue.sync  { print("end") }


// sync: queue에 작업을 넣어두면 다음 queue는 이전 queue의 작업이 끝날 때 까지 대기
// async: queue에 작업을 넣었을때 이전 queue의 작업이 끝나지 않아도 수행이 가능하다

// Swift는 Thread-Safe를 고려하고 디자인한 언어가 아니기 때문에 모든 property는 nonatomic이며 별도로 atomic도 지정할 수 없다.(GCD를 통해 적절히 컨트롤 해야한다.)

// MARK: - 왜 DispatchQueue.main.sync를 사용하지 않아야 하는가?

let serialQueue = DispatchQueue(label: "serial")

//serialQueue.async { // outer
//	print("outer start")
//	serialQueue.sync { // inner
//		print("inner")
//	}
//	print("outer end")
//}

/// iOS에서는 기본적으로 Thread를 지정하지 않으면 main thread에서 실행
DispatchQueue.main.async { // outer
	print("outer start")
	DispatchQueue.main.sync { // inner
		print("inner")		// Deadlock 상태에 빠진다.
	}
	print("outer end")
}

//여기서 outer가 sync, async인지 보다 inner가 sync인게 중요합니다.
//outer가 sync로 실행하든 async로 실행하든 일단 실행하면 끝나야 합니다.
//하지만 outer가 끝나려면 inner가 끝나야합니다. inner는 sync로(순차적으로) 실행되기 때문에 outer가 끝나야 시작됩니다.
//따라서 서로 끝나기를 기다리는 무한 대기 상태(데드락)에 빠집니다.

/// main.sync 가 쓰이는 케이스
DispatchQueue.global().async {
	// UI 업데이트 전 실행되어야만 하는 코드
	DispatchQueue.main.sync {
		// UI 업데이트
	}
	// UI 업데이트 후에 실행되어야만 하는 코드
}

// MARK: - 예제 1
print("\n\n=============== 예제 1 ===============\n\n")

//let serialQueue1 = DispatchQueue(label: "serial1")
//let serialQueue2 = DispatchQueue(label: "serial2")
//
//let concurrentQueue1 = DispatchQueue(label: "concurrent1", attributes: .concurrent)
//let concurrentQueue2 = DispatchQueue(label: "concurrent2", attributes: .concurrent)
//
//concurrentQueue1.sync {
//	for i in 0..<5 {
//		print("main async \(i) 😍")
//	}
//	//	serialQueue1.sync {
//	//		for i in 0..<5 {
//	//			print("main async \(i) 👻")
//	//		}
//	//	} main.async 를 했던것 처럼 앱이 죽는다.
//}
//
//concurrentQueue1.async {
//	for i in 0..<5 {
//		print("main async \(i) 👻")
//	}
//}
//
//for i in 0..<5 {
//	print("main async \(i) 🐶")
//}

// MARK: - 예제 2
print("\n\n=============== 예제 2 ===============\n\n")

//let queue1 = DispatchQueue(label: "queue1", attributes: .concurrent)
//let queue2 = DispatchQueue(label: "queue2", attributes: .concurrent)
//
//let iteration = 10
//
//var unsafeArray = Array(repeating: -1, count: iteration)
//var safeArray = Array(repeating: -1, count: iteration)
//
//DispatchQueue.global().async {
//	queue1.async {
//		for idx in 0..<iteration {
//			unsafeArray[idx] = 0
//		}
//	}
//	queue2.async {
//		for idx in 0..<iteration {
//			safeArray[idx] = 0
//		}
//	}
//}
//
////sleep(1)	// sleep 유무에 따라 결과가 달라짐
//print("unsafe", unsafeArray)
//print("safe", safeArray)

// MARK: - 예제 3
print("\n\n=============== 예제 3 ===============\n\n")

//let queue1 = DispatchQueue(label: "con1", attributes: .concurrent)
//let queue2 = DispatchQueue(label: "con2", attributes: .concurrent)
//
//let iteration = 100
//
//var unsafeArray = Array(repeating: -1, count: iteration)
//var safeArray = Array(repeating: -1, count: iteration)
//
//DispatchQueue.concurrentPerform(iterations: iteration) { (idx) in
//	queue1.async {
//		unsafeArray[idx] = 0
//	}
//	queue2.async(flags: DispatchWorkItemFlags.barrier) {
//		safeArray[idx] = 0
//	}
//}
//
////sleep(3)
//print("unsafe", unsafeArray)
//print("safe", safeArray)

/* 결과
unsafe - 0과 -1이 섞인 배열
safe  - 전체 0
*/

// MARK: - 예제 4
print("\n\n=============== 예제 4 ===============\n\n")

//func writeContent(txtFileUrl: URL, savedContent: String, newContent: String) {
//	let text = savedContent + newContent
//	try? text.write(to: txtFileUrl, atomically: true, encoding: .utf8)
//}
//
//let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//let txtFileUrl = documentsDirectoryURL.appendingPathComponent("sample.txt")
//writeContent(txtFileUrl: txtFileUrl, savedContent: "", newContent: "")
//
//let task: (String) -> Void = { suffix in
//	(1...100).forEach { content in
//		let str = "\(content)" + suffix
//		if let savedContent = try? String(contentsOf: txtFileUrl, encoding: .utf8) {
//			writeContent(txtFileUrl: txtFileUrl, savedContent: savedContent, newContent: str)
//		}
//	}
//}

//let serialQueue1 = DispatchQueue(label: "serial1")
//let serialQueue2 = DispatchQueue(label: "serial2")
//
//let concurrentQueue1 = DispatchQueue(label: "concurrent1", attributes: .concurrent)
//let concurrentQueue2 = DispatchQueue(label: "concurrent2", attributes: .concurrent)

//DispatchQueue.global().async {
//	task("😍 ")
//}
//
//DispatchQueue.global().async {
//	task("👻 ")
//}

//serialQueue1.sync {
//	task("😍 ")
//}
//
//serialQueue2.sync {
//	task("👻 ")
//}

//task("😍 ")
//task("👻 ")
//
//sleep(1)
//do {
//	let text2 = try String(contentsOf: txtFileUrl, encoding: .utf8)
//	print(text2)
//} catch {/* error handling here */}

// 원하는 결과 1a 2a 3a ... 100a 1b 2b 3b ... 100b
/* 예시 결과 -  결과는 조금씩 다릅니다.
result 1a 2a 3a 4a 5a 6a 7a 8a 9a 10a 11a 12a 13a 14a 15a 16a 15b 16b 17b 18b 19b 20b
21b 22b 23b 24b 25b 26b 27b 28b 29b 30b 31b 32b 33b 34b 36a 37a 38a 39a 40a
41a 42a 43a 44a 45a 46a 47a 48a 49a 48b 49b 50b 51b 52b 54a 55a 56a 57a 58a 59a 60a
61a 62a 63a 64a 65a 65b 66b 67b 68b 69b 70a 71a 72a 73a 73b 74b 75b 76b 77a 78a 79a 80a
81a 82a 83a 84a 85a 86a 87a 88a 89a 89b 90b 91b 92a 93a 94a 95a 96a 97a 98a 99a 100a 100b
*/

/// DispatchSemaphore로 critical section을 관리
// MARK: - 예제 5
print("\n\n=============== 예제 5 ===============\n\n")

//// (#1) DispatchSemaphore 초기값 0으로 설정
//let semaphore = DispatchSemaphore(value: 0)		// value 가 음수가 되면 자원을 받기 전까지 기다려야 한다.
//print("task A가 끝나길 기다림")
//// 다른 스레드에서 task A 실행
//DispatchQueue.global(qos: .background).async {
//
//	//임계 구역(critical section)
//	print("공유 자원 접근 시작 🌹")
//	sleep(2)
//
//	//task A
//	print("task A 시작!")
//	print("task A 진행중..")
//	print("task A 끝!")		// (#4)
//
//	//task A 끝났다고 알려줌
//	print("공유 자원 접근 종료 🥀")
//	semaphore.signal()
//}
//// task A 끝날때까지는 value 가 0이라, task A 종료까지 block
//semaphore.wait()		// (#2) DispatchQueue가 global에서 background로 실행되기 때문에 여기서 먼저 value 를 -1로 변경
//print("task A 완료됨")	// (#3) value가 -1(음수) 이기 때문에 자원을 얻지 못하고 기다린다.

// MARK: - 예제 6
print("\n\n=============== 예제 6 ===============\n\n")

// 공유 자원에 접근 가능한 작업 수를 2개로 제한
//let semaphore = DispatchSemaphore(value: 2)
//
//for i in 1...5 {
//	semaphore.wait() //semaphore 감소
//	DispatchQueue.global().async() {
//		//임계 구역(critical section)
//		print("공유 자원 접근 시작 \(i) 🌹")
//		sleep(3)
//		print("공유 자원 접근 종료 \(i) 🥀")
//		semaphore.signal() //semaphore 증가
//	}
//}

// MARK: - 예제 7
print("\n\n=============== 예제 7 ===============\n\n")

class Account {
	var lock = DispatchSemaphore(value: 1)
	var number: String
	init(number: String) {
		self.number = number
	}
}
func solution(_ accountNumber1:String, _ accountNumber2:String, _ count:Int) -> Bool {
	let dispatchQueue = DispatchQueue(label: "test", attributes: .concurrent)
	let account1 = Account(number: accountNumber1)
	let account2 = Account(number: accountNumber2)
	for i in 1...count {
		dispatchQueue.async {
			if i%2 == 0 {
				transfer(account1, account2, i)	// 그 다음 수행
			} else {
				transfer(account2, account1, i)	// 먼저 수행
			}
		}
	}
	return true
}
func transfer(_ from: Account, _ to: Account, _ money: Int) {
	let fromAccount = from
	let toAccount = to

	DispatchQueue.main.sync {	// 필수!!, 없으면 deadlock 걸림

		fromAccount.lock.wait()
		toAccount.lock.wait()
		print("Transfer \(money) from \(fromAccount.number) to \(toAccount.number)")
		fromAccount.lock.signal()
		toAccount.lock.signal()

	}
}


if solution("123", "456", 5) {
	print("프로세스 종료 확인")
}
