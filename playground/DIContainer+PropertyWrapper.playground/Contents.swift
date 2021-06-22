import Foundation

protocol Eatable {
	var calorie: Int { get }
}

protocol CityPresentable {
	var code: String { get }
	var name: String { get }
}

struct Pizza: Eatable {
	var calorie: Int {
		return 300
	}
}

struct Seoul: CityPresentable {
	var code: String {
		return "02"
	}

	var name: String {
		return "서울"
	}
}

struct FoodTruck {
	let food: Eatable
	let city: CityPresentable

	init(food: Eatable, city: CityPresentable) {
		self.food = food
		self.city = city
	}
}

class DIContainer {

	static let shared = DIContainer()

	private var dependencies = [String: Any]()

	private init() {}

	func register<T>(_ dependency: T) {
		let key = String(describing: type(of: T.self))
		dependencies[key] = dependency
	}

	func resolve<T>() -> T {
		let key = String(describing: type(of: T.self))
		let dependency = dependencies[key]

		precondition(dependency != nil, "\(key)는 register되지 않았어어요. resolve 부르기전에 register 해주세요")

		return dependency as! T
	}
}

DIContainer.shared.register(Pizza())
DIContainer.shared.register(Seoul())

let pizza: Pizza = DIContainer.shared.resolve()
let seoul: Seoul = DIContainer.shared.resolve()

DIContainer.shared.register(FoodTruck(food: pizza,
									  city: seoul))

let foodTruck: FoodTruck = DIContainer.shared.resolve()
print(foodTruck)


@propertyWrapper
class Dependency<T> {

	let wrappedValue: T

	init() {
		self.wrappedValue = DIContainer.shared.resolve()
	}
}

class ViewController {
	@Dependency var foodTruckWithWrapper: FoodTruck
}

let vc = ViewController()
print(vc.foodTruckWithWrapper)
