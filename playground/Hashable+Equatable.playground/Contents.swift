import Foundation

var str = "Hello, playground"

struct JH: Hashable {	// 구조체의 프로퍼티가 전부 Hashable을 준수하면 채택이 가능하다.
	let name: String
}

var dict1: [JH: String] = [:]

let jh = JH(name: "종호")

dict1[jh] = "리"
dict1

var set1: Set<JH> = Set()
set1.insert(jh)
set1

enum JHEnum: Hashable {
	case hoho(String)	// "관련값" 을 사용하는 경우 Hashable을 준수해야한다.
	case jojo
}

var dict2: [JHEnum: String] = [:]
dict2[.hoho("You~!")] = ""

var set2: Set<JHEnum> = Set()
set2.insert(.hoho("Hey~!"))
