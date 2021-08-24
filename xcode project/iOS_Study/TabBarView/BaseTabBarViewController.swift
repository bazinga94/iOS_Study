//
//  BaseTabBarViewController.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/08/24.
//

import UIKit

class BaseTabBarViewController: UITabBarController {
	var customTabBar: TabNavigationMenu!
	var tabBarHeight: CGFloat = 67.0

	override func viewDidLoad() {
		super.viewDidLoad()
		self.loadTabBar()
	}

	private func loadTabBar() {
		// We'll create and load our custom tab bar here
	}

	func setupCustomTabMenu(_ menuItems: [TabBarItem], completion: @escaping ([UIViewController]) -> Void) {
		// handle creation of the tab bar and attach touch event listeners
	}

	func changeTab(tabIndex: Int) {
		self.selectedIndex = tabIndex
	}
}
