import Foundation

extension String {
	func base64Encoded() -> String? {
		return data(using: .utf8)?.base64EncodedString()
	}

	func base64Decoded() -> String? {
		guard let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters) else { return nil }
		return String(data: data, encoding: .utf8)
	}
}

"heroes".base64Encoded() // It will return: aGVyb2Vz
"aGVyb2Vz".base64Decoded() // It will return: heroes


"VYy8x4TVYG2Byzz9AY7CSQ==".base64Decoded()
"A8zAw8H+juvYQzZ5wWwNzA==".base64Decoded()

// yh8JNPApG5n4qblZQsSQMQ==

// A8zAw8H+juvYQzZ5wWwNzA==

"heroes".base64encoded
"aGVyb2Vz".base64Decoded

//extension String {
//	func urlSafeBase64Decoded() -> String? {
//		var st = self
//			.replacingOccurrences(of: "_", with: "/")
//			.replacingOccurrences(of: "-", with: "+")
//		let remainder = self.count % 4
//		if remainder > 0 {
//			st = self.padding(toLength: self.count + 4 - remainder,
//							  withPad: "=",
//							  startingAt: 0)
//		}
//		guard let d = Data(base64Encoded: st, options: .ignoreUnknownCharacters) else{
//			return nil
//		}
//		print(d)
//		return String(data: d, encoding: .utf8)
//	}
//}
//
//"ExPOSiPdRPSOvshJdtrH9A==".urlSafeBase64Decoded()

//extension String {
//	var base64Decoded1: String? {
//		guard let base64 = Data(base64Encoded: self) else { return nil }
//		let utf8 = String(data: base64, encoding: .)
//		return utf8
//	}
//}


extension String {
	var base64Decoded: String? {
		guard let base64 = Data(base64Encoded: self, options: .ignoreUnknownCharacters) else { return nil }
		//		print(base64.count)
		//		let utf8 = String(data: base64, encoding: .utf8)

		let bytes = [UInt8](base64)
		print(bytes)

		let datastring = String(bytes: bytes, encoding: .utf8)

		return datastring
	}
}

//let chars : [UInt8] = [72, 101, 108, 108, 111]
func test() {
	//	let nonce = "ExPOSiPdRPSOvshJdtrH9A=="
	//	let nonce = "QeYJ0jixeovAsc8bYPX/mA=="
	let nonce = "yahN21fA3XKhZAECL8KsnQ=="
	guard let base64 = Data(base64Encoded: nonce) else { return }
	var chars = [UInt8](base64)
	//var chars: [UInt8] = [19, 19, 206, 74, 35, 221, 68, 244, 142, 190, 200, 73, 118, 218, 199, 244]

	var result1 = chars.reduce("", { $0 + String(format: "%c", $1)})
	//var result = chars.reduce("", { $0 + String(format: "%02x", $1)})
	print(result1)
	let result2 = ((result1 as NSString).utf8String)
	print(result2)
}

test()
//let datastring = String(bytes: chars, encoding: .utf8) // "Hello"

//let byte2: UInt8 = 10
//let characterFromByte: [Character] = chars.map { Character }
//print(characterFromByte)

"ExPOSiPdRPSOvshJdtrH9A==".base64Decoded




//let utf8str = "PY5ehymWfQKExWxPyOImGiQkxNjyuBREmOXtQdePVpuH9PFzizaO+WTuM1sLouTQPz5UO7csloC9GjOFqkq4POmlB9d3mMJGLB2pVCNs8t9EejOcjV4fRHaITkmfMfVbizCnTvHGBwLWXjLc7gwyhu2+S9qw0NXc5jw6EdEk+zuesrdwLgqws0hDqFSoVw57+CnvUmgXwtNfKP4p64mJ9inH/0xAMarCc5N4Wjz/zmlTyd2PoDFUC/iLdZ7csau7X2M=".data(using: .utf8)
//let base64Encoded = utf8str?.base64EncodedStringWithOptions(NSData.Base64EncodingOptions(rawValue: 0))
//let encodedString : String = base64Encoded!
//print(encodedString) // my encoded data
//
//let decodedData = NSData(base64Encoded:  encodedString, options:NSData.Base64DecodingOptions(rawValue: 0))
//let decodedString : String = String(data: decodedData! as Data, encoding: String.Encoding.utf8)!
//print(decodedString) // my plain data


//
//extension String {
//	var base64Decoded: String? {
//		guard let base64 = Data(base64Encoded: self) else { return nil }
//		print(NSString(data: base64, encoding: String.Encoding.utf8.rawValue))
//		print(base64.base64EncodedString())
//		let utf8 = String(data: base64, encoding: .utf8)
//		return utf8
//	}
//}

"ExPOSiPdRPSOvshJdtrH9A==".base64Decoded

var encoded64 = "ExPOSiPdRPSOvshJdtrH9A=="

let remainder = encoded64.count % 4
if remainder > 0 {
	encoded64 = encoded64.padding(toLength: encoded64.count + 4 - remainder,
								  withPad: "=",
								  startingAt: 0)
}

print(encoded64)


