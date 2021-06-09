import UIKit

class Target: NSObject {
	@objc dynamic var text: String

	init(text: String) {
		self.text = text
	}
}

var target = Target(text: "안녕")

target.observe(\.text, options: [.old, .new]) { (object, change) in
	print(change.oldValue, change.newValue)
}

target.text = "hey~"

// NSObject 를 상속해야 하는데 -> Objective - C 런타임에 의존하게 된다.
// @objc -> 클래스, 메소드, 프로퍼티를 Objective - C 에서 사용할 때
// dynamic 키워드 Objective - C 런타임에 사용, Message Dispatch: 객체의 메소드나 프로퍼티에 접근 할 때 객체에게 메시지를 보내고 객체가 해당하는 메소드나 프로퍼티 위치를 찾아서 실행
// dynamic dispatch는 코어데이터나 KVO 은 Objective - C 런타임에서 가능함
