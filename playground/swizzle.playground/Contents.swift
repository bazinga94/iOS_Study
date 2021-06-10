import UIKit

class Thing : NSObject {
	@objc dynamic
	func original(x: Int) {
		print("original called")
	}
}

extension Thing {
	@objc dynamic
	func replacement(x: Int) {
		print("replacement called")
	}
}

func beforeAfter() {
	let thing = Thing()
	thing.original(x: 10) // calls original(x:)
	let origMethod = #selector(Thing.original(x:))
	let replacementMethod = #selector(Thing.replacement(x:))
	let method: Method? = class_getInstanceMethod(Thing.self, origMethod)
	let swizzleMethod: Method? = class_getInstanceMethod(Thing.self, replacementMethod)
	let swizzleImpl = method_getImplementation(swizzleMethod!)
	method_setImplementation(method!, swizzleImpl);
	thing.original(x: 10) // calls replacement(x:)
}

beforeAfter()

// 메소드 그 자체를 변경 할 수 있는 방법이 있다...!
// https://developer.apple.com/documentation/objectivec/1418677-class_replacemethod
// https://forums.swift.org/t/dynamic-method-replacement/16619
// https://jcsoohwancho.github.io/2020-02-02-Selector%EC%99%80-Method-Swizzling/
// https://zeddios.tistory.com/554

extension UIViewController {

	static let swizzleMethod: Void = {
		let originalSelector = #selector(viewWillAppear)
		let swizzledSelector = #selector(swizzleViewWillAppear)
		let originalMethod = class_getInstanceMethod(UIViewController.self, originalSelector)
		let swizzledMethod = class_getInstanceMethod(UIViewController.self, swizzledSelector)
		let originalImplementation = class_getMethodImplementation(UIViewController.self, originalSelector)
		let swizzledImplementation = class_getMethodImplementation(UIViewController.self, swizzledSelector)
		if let origin = originalMethod, let swizzle = swizzledMethod, let originImp = originalImplementation, let swizzledImp = swizzledImplementation {
			method_setImplementation(origin, swizzledImp)
			method_setImplementation(swizzle, originImp)
			//			method_exchangeImplementations(origin, swizzle)
		}
	}()

	@objc
	func swizzleViewWillAppear() {
		print("swizzleViewWillAppear")
	}
}
