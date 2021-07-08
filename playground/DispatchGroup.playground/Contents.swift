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
