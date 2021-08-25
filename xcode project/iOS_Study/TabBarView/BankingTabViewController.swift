//
//  BankingTabViewController.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/08/24.
//

import UIKit

class BankingTabViewController: UIViewController {

	@IBOutlet weak var scrollView: UIScrollView!

	override func viewDidLoad() {
		super.viewDidLoad()
		self.scrollView.delegate = self
	}
}

extension BankingTabViewController: UIScrollViewDelegate {
	func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		guard let tabBarController = tabBarController as? TabBarAnimatable else { return }
		tabBarController.animateTabBar(hidden: true)
	}

	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		guard let tabBarController = tabBarController as? TabBarAnimatable else { return }
		tabBarController.animateTabBar(hidden: false)
	}

	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		guard let tabBarController = tabBarController as? TabBarAnimatable else { return }
		tabBarController.animateTabBar(hidden: false)
	}
}
