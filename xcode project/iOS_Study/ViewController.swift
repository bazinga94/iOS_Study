//
//  ViewController.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/04/29.
//

import UIKit
import Swinject

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
//		print("swizzleViewWillAppear at \(String(describing: self))")
	}
}

class ViewController: UIViewController {

	var container = Container()

	override func viewDidLoad() {
		super.viewDidLoad()

		CustomLogger.warning(tag: nil, message: "warning 로그")
		CustomLogger.info(tag: nil, message: "info 로그")
//		CustomLogger.error(tag: nil, message: "error 로그")
		CustomLogger.debug(tag: nil, message: "debug 로그")
		CustomLogger.verbose(tag: nil, message: "verbose 로그")

//		let customView = CustomView(frame: CGRect(x: 100, y: 100, width: 300, height: 300))
//		self.view.addSubview(customView)	// code로 추가
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

	@IBAction func collectionViewTest(_ sender: Any) {
		let destinationViewController = CollectionViewController()
		self.navigationController?.pushViewController(destinationViewController, animated: true)
	}


	@IBAction func rxswiftTest(_ sender: Any) {
		let destinationViewController = RxStudyViewController()
		self.navigationController?.pushViewController(destinationViewController, animated: true)
	}

	@IBAction func swinjectTest(_ sender: Any) {
		self.registerDependencies()
		let destinationViewController = SwinjectSampleViewController(worker: container.resolve(WorkProtocol.self, argument: "이종호")!)	// resolve로 반환하는 instance는 optional이다. DI 단계에서 optional로 인한 에러 처리를 어떻게 하지??
		self.navigationController?.pushViewController(destinationViewController, animated: true)
	}

	@IBAction func tabBarViewTest(_ sender: Any) {
		let storyBoard: UIStoryboard! = UIStoryboard(name: "Main", bundle: nil)
		let destinationViewController = storyBoard.instantiateViewController(withIdentifier: "BaseTabBarViewController") as! BaseTabBarViewController
		self.navigationController?.pushViewController(destinationViewController, animated: true)
	}

	private func registerDependencies() {
		self.container.register(WorkProtocol.self) { (_, name: String) in
			HardWorker(name: name)
		}
	}
}
