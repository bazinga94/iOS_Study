//
//  ViewController.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/04/29.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	@IBAction func setNeedsDisplayTest(_ sender: Any) {
		let storyBoard: UIStoryboard! = UIStoryboard(name: "Main", bundle: nil)
		let destinationViewController = storyBoard.instantiateViewController(withIdentifier: "ViewLayoutTestViewController") as! ViewLayoutTestViewController
		self.navigationController?.pushViewController(destinationViewController, animated: true)
	}
}
