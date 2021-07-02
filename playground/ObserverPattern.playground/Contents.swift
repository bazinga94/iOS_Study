import Foundation

/// Observer 등록 / 해제 protocol
protocol Observable {
	func addObserver(_ observer: Observer)
	func removeObserver(_ observer: Observer)
}

/// Observer protocol
protocol Observer: class {
	var delegate: TaskManagerDelegate? { get set }
	func taskStart()
	func notifyFail()
}

/// Observer 관리 class
class ObserverManager: Observable {
	var observers: [Observer] = []

	func addObserver(_ observer: Observer) {
		observers.append(observer)
	}

	func removeObserver(_ observer: Observer) {
		observers = observers.filter { $0 !== observer }		// ===, !== 클래스 주소값 비교!!
	}
}

protocol TaskManagerDelegate: class {
	func oneTaskCompleted(by observer: Observer)
	func oneTaskFailed()
}

class SomeTaskManager: ObserverManager, TaskManagerDelegate {
	/// 전체 task process 시작
	func allTaskStart() {
		print("All task start!")

		for observer in observers {
			DispatchQueue.global().async {
				observer.delegate = self
				observer.taskStart()
			}
		}
	}

	/// 하나의 task 완료
	func oneTaskCompleted(by observer: Observer) {
		removeObserver(observer)
		if observers.isEmpty {
			allTaskCompleted()
		}
	}

	/// 모든 task 완료
	private func allTaskCompleted() {
		print("All task completed! :)")
	}

	/// 하나의 task라도 실패하면 실패
	func oneTaskFailed() {
		observers.forEach {
			$0.notifyFail()
		}
		print("Task failed! :(")
	}
}

class Task1: Observer {
	weak var delegate: TaskManagerDelegate?

	func taskStart() {
		print("\(String(describing: self)) start")
		for i in (1...10) {
			print("\(String(describing: self)) progressing \(10 * i)/100")
			sleep(1)
//			if i == 2 {
//				delegate?.oneTaskFailed()
//				return
//			}	// Task 실패 케이스
		}
		print("\(String(describing: self)) end")
		delegate?.oneTaskCompleted(by: self)
	}

	func notifyFail() {
	}
}

class Task2: Observer {
	weak var delegate: TaskManagerDelegate?

	func taskStart() {
		print("\(String(describing: self)) start")
		for i in (1...5) {
			print("\(String(describing: self)) progressing \(20 * i)/100")
			sleep(1)
		}
		print("\(String(describing: self)) end")
		delegate?.oneTaskCompleted(by: self)
	}

	func notifyFail() {
	}
}

class Task3: Observer {
	weak var delegate: TaskManagerDelegate?

	func taskStart() {
		print("\(String(describing: self)) start")
		for i in (1...4) {
			print("\(String(describing: self)) progressing \(25 * i)/100")
			sleep(1)
		}
		print("\(String(describing: self)) end")
		delegate?.oneTaskCompleted(by: self)
	}

	func notifyFail() {
	}
}

let task1 = Task1()
let task2 = Task2()
let task3 = Task3()

let someTaskManeger = SomeTaskManager()
someTaskManeger.addObserver(task1)
someTaskManeger.addObserver(task2)
someTaskManeger.addObserver(task3)

someTaskManeger.allTaskStart()
