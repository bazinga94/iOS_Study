import UIKit

protocol SomeProtocol {
	func action() -> Int
}

// MARK: Value Type
struct SomeStruct: SomeProtocol {
	func action() -> Int {
		return 1
	}
}

let s = SomeStruct()
s.action()	// static dispatch

// MARK: Reference Type
class SomeClass1 {
	func action() -> Int {
		return 2
	}

//	final func action() -> Int {
//		return 2
//	}	// final 키워드를 사용하면 static dispatch를 사용할 수 있다
}

class DerivedClass1: SomeClass1 {
	override func action() -> Int {
		return 3
	}
}

var c1: SomeClass1 = SomeClass1()
c1.action()	// dynamic dispatch
c1 = DerivedClass1()
c1.action()	// dynamic dispatch

// MARK: Protocol

class SomeClass2: SomeProtocol {
	func action() -> Int {
		return 1
	}
}

class DerivedClass2: SomeClass2 {
	override func action() -> Int {
		return 2
	}
}

var c2: SomeProtocol = SomeClass2()
c2.action()	// dynamic dispatch
c2 = DerivedClass2()
c2.action()	// dynamic dispatch

// MARK: Extension

extension SomeClass1 {
	func anotherAction() -> Int {
		return 4
	}

//	override func action() -> Int {
//		return 5
//	}	// class 본체의 함수 오버라이드 불가능

//	override func anotherAction() -> Int {
//		return 5
//	}	// extension에 선언된 함수 오버라이드 불가능

// 따라서 extension의 메소드는 static dispatch가 가능
}

var c3: SomeClass1 = SomeClass1()
c3.anotherAction()	// static dispatch
c3 = DerivedClass1()
c3.anotherAction()	// static dispatch

// MARK: Protocol with Extension

extension SomeProtocol {
	func action() -> Int {
		return 6
	}
}

class SomeClass3: SomeProtocol {
	func action() -> Int {
		return 7
	}
}

class DerivedCalss3: SomeClass3 {
	override func action() -> Int {
		return 8
	}
}

var c4: SomeProtocol = SomeClass3()
c4.action()	// dynamic dispatch
c4 = DerivedCalss3()
c4.action()	// dynamic dispatch

// 본체 class에 선언된 메소드를 protocol에서 extension으로 제공하는 경우
// Table Dispatch를 통해 실행될 메소드를 선택

protocol AnotherProtocol {
}

extension AnotherProtocol {
	func action() -> Int {
		return 9
	}
}

class SomeClass4: AnotherProtocol {
	func action() -> Int {
		return 10
	}
}

class DerivedCalss4: SomeClass4 {
	override func action() -> Int {
		return 11
	}
}

var c5: AnotherProtocol = SomeClass4()
c5.action()	// static dispatch
c5 = DerivedCalss4()
c5.action()	// static dispatch

// 본체 class에 없는 메소드를 제공한 경우
// Table을 사용할 수 없음!



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

