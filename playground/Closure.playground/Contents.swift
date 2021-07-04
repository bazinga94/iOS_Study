import Foundation

// https://velog.io/@kimdo2297/%ED%81%B4%EB%A1%9C%EC%A0%B8-%EC%BA%A1%EC%B3%90%EC%97%90-%EB%8C%80%ED%95%B4%EC%84%9C-about-closure-capture 참고

class Pokemon {
	var name: String
	init(name: String) {
		self.name = name
	}
	deinit { print("\(self.name) escaped!") }
}

func delay(_ seconds: Int, closure: @escaping ()->()) {
	let time = DispatchTime.now() + .seconds(seconds)
	DispatchQueue.main.asyncAfter(deadline: time) {
		print("🕑")
		closure()
	}
}

func demo1() {
	let pokemon = Pokemon(name: "Mewtwo")
	print("before closure: \(pokemon.name)")
	delay(1) {
		print("inside closure: \(pokemon.name)")
	}
	print("bye")
}

//demo1()

func demo2() {
	var pokemon = Pokemon(name: "Pikachu")
	print("before closure: \(pokemon.name)")
	delay(1) {
		print("inside closure: \(pokemon.name)")
	}
	pokemon = Pokemon(name: "Mewtwo")
	print("after closure: \(pokemon.name)")
}

//demo2()

func demo3() {
	var pokemon = Pokemon(name: "Pikachu")
	print("before closure: \(pokemon.name)")
	delay(1) { [pokemon] in
		print("inside closure: \(pokemon.name)")
	}
	pokemon = Pokemon(name: "Mewtwo")
	print("after closure: \(pokemon.name)")
}

//demo3()

// ----- struct vs class

struct StructPokemon {
	var name: String
	init(name: String) {
		self.name = name
	}
}

func demo4() {
	var pokemon = StructPokemon(name: "Pikachu")
	print("before closure: \(pokemon.name)")
	delay(1) { [pokemon] in
		print("inside closure: \(pokemon.name)")
	}
	pokemon.name = "Mewtwo"
	print("after closure: \(pokemon.name)")
}

demo4()

func demo5() {
	let pokemon = Pokemon(name: "Pikachu")
	print("before closure: \(pokemon.name)")
	delay(1) { [pokemon] in
		print("inside closure: \(pokemon.name)")
	}
	pokemon.name = "Mewtwo"
	print("after closure: \(pokemon.name)")
}

//demo5()
