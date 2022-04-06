import UIKit
import Combine

// 참고: https://github.com/seungwook-jung/Kombine/wiki

var name = "dongKyu"
print(name)
DispatchQueue.global().async {
	name = "kyuDong"
}
name += "Working Hard"
print(name)
