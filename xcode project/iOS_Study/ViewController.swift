//
//  ViewController.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/04/29.
//

import UIKit

extension UIViewController {
	class func swizzleMethod() {
		let originalSelector = #selector(viewWillAppear)
		let swizzleSelector = #selector(swizzleViewWillAppear)

		guard
			let originMethod = class_getInstanceMethod(UIViewController.self, originalSelector),
			let swizzleMethod = class_getInstanceMethod(UIViewController.self, swizzleSelector)
		else { return }

		method_exchangeImplementations(originMethod, swizzleMethod)
	}

	@objc public func swizzleViewWillAppear(animated: Bool) {
		print("swizzleViewWillAppear at \(String(describing: self))")
	}
}

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		CustomLogger.warning(tag: nil, message: "warning 로그")
		CustomLogger.info(tag: nil, message: "info 로그")
//		CustomLogger.error(tag: nil, message: "error 로그")
		CustomLogger.debug(tag: nil, message: "debug 로그")
		CustomLogger.verbose(tag: nil, message: "verbose 로그")
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		print("original view will appear")
	}

	@IBAction func setNeedsDisplayTest(_ sender: Any) {
		let storyBoard: UIStoryboard! = UIStoryboard(name: "Main", bundle: nil)
		let destinationViewController = storyBoard.instantiateViewController(withIdentifier: "ViewLayoutTestViewController") as! ViewLayoutTestViewController
		self.navigationController?.pushViewController(destinationViewController, animated: true)
	}
}
