import Foundation


struct Bread {
	var taste: String
}

let b = Bread.init(taste: "AA")
b.taste = "ddd"

//
//class Bread {
//	var taste: String
//	init(taste: String) {
//		self.taste = taste
//	}
//}
//
//let bb = Bread.init(taste: "AA")
//bb.taste = "ccc"
