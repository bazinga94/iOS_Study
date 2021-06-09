import UIKit



class Parent {
	func doSomething() {
		print("Parent")
	}
}

class Child: Parent {
	override func doSomething() {
		print("Child")
	}
}

let instance: Parent = Child()
instance.doSomething()	// 타입은 Parent protocol 이지만 Child의 doSomething()이 실행된다(dynamic)

protocol Fighter{
	func fight() //Requirement
}
extension Fighter{
	//Requirement
	func fight(){
		self.punch()
	}
	//Static method (it is not required in the protocol)
	func punch(){
		print("Fighter punch")
	}
}

protocol MagicalFighter : Fighter{
	func castSpell() //Requirement
}
extension MagicalFighter{
	//Requirement
	func castSpell(){
		print("MagicalFighter casted a spell")
	}
	//Static
	func punch(){
		self.castSpell()
		print("Magical fighter punch")
	}
}

struct Hero : MagicalFighter{
	func castSpell(){
		print("Hero casted special spell")
	}
}

let gordo = Hero()
gordo.fight()
gordo.punch()	// Fighter extension에서 구현한 punch()가 실행된다.


