import Foundation

var output:String?
var string = "dklsdfkl*dl"

if string.hasPrefix("*") {
	output = string.substringFromIndex(string.startIndex.advancedBy(1))
}

output
