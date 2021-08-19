//
//  SwinjectSampleViewController.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/08/19.
//

import UIKit

protocol WorkProtocol {
	func workHard()
}

class HardWorker: WorkProtocol {
	func workHard() {
		print("I work hard !!")
	}
}

class SwinjectSampleViewController: UIViewController {

	let worker: WorkProtocol

	init(worker: WorkProtocol) {
		self.worker = worker
		super.init(nibName: nil, bundle: nil)
	}

	required init ? (coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		worker.workHard()
	}
}
