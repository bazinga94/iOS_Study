import Foundation

// DispatchGroup이란 서로 다른 task들 그룹화하여 task들이 완료될 때까지 기다리거나 완료되면 알림을 받을 수 있도록 하는것

//let myQueue = DispatchQueue(label: "com.nil.work", attributes: .concurrent)
//let myGroup = DispatchGroup()
//
//myGroup.enter()		// myGroup에 task 포함
//myQueue.async {
//	for i in 1...10 {
//		print("\(i)")
//	}
//	myGroup.leave()	// DispatchGroup에 해당 task가 완료되었다고 알림
//}
//
//myGroup.enter()		// myGroup에 task 포함
//myQueue.async {
//	for i in 100...105 {
//		print("\(i)")
//	}
//	myGroup.leave()	// DispatchGroup에 해당 task가 완료되었다고 알림
//}
//
//myGroup.notify(queue: myQueue) {	// 각각의 task가 끝나고 나서 필요한 작업을 한다.
//	print("end...")
//}

// MARK: - 가독성이 더 좋게

let myQueue = DispatchQueue(label: "concurrent", attributes: .concurrent)
let myGroup = DispatchGroup()

myQueue.async(group: myGroup) {
	for i in 1...10 {
		print("\(i)")
	}
}
myQueue.async(group: myGroup) {
	for i in 100...105 {
		print("\(i)")
	}
}
myGroup.notify(queue: myQueue) {
	print("end...")
}
myQueue.async(group: myGroup) {
	for i in 1000...1005 {
		print("\(i)")
	}
}

//let semaphore = DispatchSemaphore(value: 0)
//let group = DispatchGroup()
//let queue = DispatchQueue(label: "map-reduce", qos: .userInitiated, attributes: .concurrent)
//let stopAtFirst = true // false for all results to be appended into one array
//let values: [U] = <some input values>
//let mapper: (U) throws -> T? = <closure>
//var result: [T?] = []
//
//for value in values {
//	queue.async(group: group) {
//		do {
//			let res = try mapper(value)
//			// appending must always be thread-safe, otherwise you end up with race condition and unstable results
//			DispatchQueue.global().sync {
//				result.append(res)
//			}
//			if stopAtFirst && res != nil {
//				semaphore.signal()
//			}
//		} catch let error {
//			print("Could not map value \"\(value)\" to mapper \(mapper): \(error)")
//		}
//	}
//}
//group.notify(queue: queue) { // this must be declared exactly after submitting all tasks, otherwise notification fires instantly
//	semaphore.signal()
//}
//if semaphore.wait(timeout: .init(uptimeNanoseconds: 5)) == .timedOut {
//	print("MapReduce timed out on values \(values)")
//}

