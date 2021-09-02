import UIKit

@dynamicMemberLookup
struct Contact {
	var persons: [String: String]

	subscript(dynamicMember planet: String) -> String? {
		get {
			return persons[planet]
		}
		set {
			persons[planet] = newValue
		}
	}
}

var contact = Contact(persons: [ "지구": "Zedd", "달": "Marshmello" ])
let zedd = contact[dynamicMember: "지구"]		// subscript 구현
contact[dynamicMember: "목성"] = "Ian"		// array 에 set도 가능
contact.지구		// dynamicMemberLookup 이 가능하게 해줌
contact.몰랑


struct Address {
	var town: String
}

struct Person {
	var address: Address
}

let address = Address(town: "어쩌구")
let zedd = Person(address: address)
let zeddAddress = zedd[keyPath: \.address]
let zeddTown = zedd[keyPath: \.address.town]
print(zeddTown) // 어쩌구


