import Foundation

extension String {
	func base64Encoded() -> String? {
		return data(using: .utf8)?.base64EncodedString()
	}

	func base64Decoded() -> String? {
		guard let data = Data(base64Encoded: self) else { return nil }
		return String(data: data, encoding: .utf8)
	}
}

"heroes".base64Encoded() // It will return: aGVyb2Vz
"aGVyb2Vz".base64Decoded() // It will return: heroes


"A8zAw8H+juvYQzZ5wWwNzA==".base64Decoded()

// yh8JNPApG5n4qblZQsSQMQ==

// A8zAw8H+juvYQzZ5wWwNzA==

"heroes".base64encoded
"aGVyb2Vz".base64Decoded

