import UIKit
import Combine

// 참조: https://zeddios.tistory.com/925

// MARK: -------------- Publisher --------------
print("-------------- Publisher --------------")

class ClubHouseHandsUp: Publisher {
	typealias Output = String
	typealias Failure = Never

	func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
		DispatchQueue.global(qos: .utility).async {
			let dummy: [String] = ["jack", "tom"]
			dummy.forEach {
				_ = subscriber.receive($0)
			}
			subscriber.receive(completion: .finished)
		}
	}
}

let handsupPublisher = ClubHouseHandsUp()

_ = handsupPublisher.sink(receiveCompletion: { _ in
	print("completed")
}) {
	print($0)
}

_ = handsupPublisher.sink(receiveValue: { value in
	print(value)
})

// Publisher를 구동하는 방법은 3가지
// 1. sink
// 2. subscribe  <--
// 3. assign(to: on:)

// MARK: -------------- Subscribe --------------
print("-------------- Subscribe --------------")

class SampleSubscriber: Subscriber {
	typealias Input = String

	typealias Failure = Never

	/// subscriber에게 publisher를 성공적으로 구독했음을 알리고 item을 요청할 수 있음
	/// - Parameter subscription: 최대 구독 수(예약 구독) ?
	func receive(subscription: Subscription) {
//		print("구독 시작")
		subscription.request(.max(1))
	}

	/// subscriber에게 publisher가 element를 생성했음을 알림
	/// - Parameter input: Input Type element
	/// - Returns: .none: "새로운 값을 받을 때 이 publisher의 demand를 변경하고 싶지 않음을 의미"
	func receive(_ input: String) -> Subscribers.Demand {
//		print(input)
//		return .none
//		return .max(3)	// -> .none 이 아닌 값을 return 하면 구독 완료 까지 호출이 잘됨.. 그 이유는?!
		if input == "Hey~" {
			return .max(1)	// max 값을 return 할때 마다 누적으로 증가 시키거나 .none or .unlimited로 변경이 가능함
		} else {
			return .none
		}
	}

	/// subscriber에게 publisher가 정상적으로 또는 오류로 publish를 완료했음을 알림
	/// - Parameter completion: publish 완료 결과
	func receive(completion: Subscribers.Completion<Never>) {
//		print("구독 완료", completion)
	}
}

//let sampleJustPublisher = Just("Hey~")
let sampleJustPublisher = ["Hey~", "lady"].publisher
//sampleJustPublisher.subscribe(SampleSubscriber())
//sampleJustPublisher.print().subscribe(SampleSubscriber())	// 사이에 print() 메소드를 포함시키면 로그로 확인 가능~

// MARK: -------------- Subject --------------
print("-------------- Subject --------------")

// 1. CurrentValueSubject
// 가장 최근에 publish된 element의 버퍼를 유지, 초기값 지정 필요
let currentValueSubject = CurrentValueSubject<String, Never>("Current value first")
let subscriber1 = currentValueSubject.sink(
	receiveValue: { print($0) }
)
currentValueSubject.value = "Current value second"
currentValueSubject.send("Current value third")


// 2. PassthroughSubject
// 가장 최근에 publish된 element의 초기값 또는 버퍼가 없음, subscribers가 없거나 현재 demand가 0이면 value를 삭제(drop)함
let passthroughSubject = PassthroughSubject<String, Never>()
let subscriber2 = passthroughSubject.sink(
	receiveValue: { print($0) }
)
passthroughSubject.send("Pass through first")
passthroughSubject.send("Pass through second")

// 3. PassthroughSubject with Error
enum SampleError: Error {
	case unknown
}

let passthroughSubjectWithError = PassthroughSubject<String, SampleError>()
let subscriber3 = passthroughSubjectWithError.sink(
	receiveCompletion: { (result) in
		switch result {
			case .finished:
				print("finished")
			case .failure(let error):
				print(error.localizedDescription)
		}
	},
	receiveValue: { (value) in
		print(value)
	}
)

passthroughSubjectWithError.send("안녕")
passthroughSubjectWithError.send("Ian")
passthroughSubjectWithError.send(completion: .failure(.unknown))
//passthroughSubjectWithError.send(completion: .finished)
passthroughSubjectWithError.send("끝나서 출력 안됨")

// MARK: -------------- Scheduler --------------
print("-------------- Scheduler --------------")
// closure의 실행 시기와 방법을 정의하는 프로토콜

//let subject = PassthroughSubject<Int, Never>()
//let token = subject.sink(
//	receiveValue: { value in
//		print(Thread.isMainThread)
//	}
//)
//subject.send(1)							// true
//DispatchQueue.global().async {
//	subject.send(2)						// false
//}
// Scheduler는 element가 생성된 스레드와 동일한 스레드를 사용.

// Scheduler Switching

let publisher = ["jong", "ho"].publisher
publisher.print().map { value in
	print("1", value)
	print(Thread.isMainThread)
} // true
//.subscribe(on: DispatchQueue.global())	// upstream의 실행 컨텍스트를 변경(?)
//.receive(on: DispatchQueue.global())	// publisher로 부터 element를 수신할 scheduler를 지정하는 역할. downstream의 실행 컨텍스트를 변경
.map {
	print("2", $0)
	print(Thread.isMainThread)
} // false
.subscribe(on: DispatchQueue.global())
.sink {
	print("3", $0)
	print(Thread.isMainThread)
} // false


// MARK: -------------- Class Future --------------

let future = Future<String, Error> { promise in
	promise(.success("jack"))
}

_ = future.sink {
	print($0)
} receiveValue: {
	print($0)
}

// 결과 : jack, finished
let futureWithError = Future<String, Error> { promise in
	promise(.failure(NSError(domain: "error", code: -1, userInfo: nil)))
}

_ = futureWithError.sink {
	print($0)
} receiveValue: {
	print($0)
}

// 결과 : failure(Error Domain=error Code=-1 "(null)")
let futureWithNever = Future<String, Never> { promise in
	promise(.success("jack"))
}
_ = futureWithNever.sink {
	print($0)
}

// 결과 : jack

// MARK: -------------- Struct Just --------------
// 각 subscriber에게 output을 한번만(just once) 출력한 다음 완료하는 publisher.
// 위에서 말했던 "Publisher"라는 프로토콜을 채택한 Struct.

let just = Just<String>("jack")

_ = just.sink {
	print($0)
} receiveValue: {
	print($0)
}

// 결과: "jack", finished
