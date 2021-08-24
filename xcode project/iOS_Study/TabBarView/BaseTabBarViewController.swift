//
//  BaseTabBarViewController.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/08/24.
//

import UIKit

class BaseTabBarViewController: UITabBarController {
	var customTabBar: TabNavigationMenu!
	var tabBarHeight: CGFloat = 120.0

	override func viewDidLoad() {
		super.viewDidLoad()
		self.loadTabBar()
	}

	private func loadTabBar() {
		let tabBarItems: [TabBarItem] = [BankingTab(), AssetTab(), BenefitTab()]		// tab을 추가하고 싶으면 여기에 Item을 추가하면 된다.
		self.setupCustomTabMenu(tabBarItems)
		self.selectedIndex = 0	// 초기 index는 0
	}

	private func setupCustomTabMenu(_ menuItems: [TabBarItem]) {
		let frame = tabBar.frame
		var viewControllers = [UIViewController]()

		tabBar.isHidden = true
		self.customTabBar = TabNavigationMenu(menuItems: menuItems, frame: frame)
		self.customTabBar.translatesAutoresizingMaskIntoConstraints = false
		self.customTabBar.clipsToBounds = true
		self.customTabBar.delegate = self

		self.view.addSubview(customTabBar)

		NSLayoutConstraint.activate([
			self.customTabBar.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
			self.customTabBar.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
			self.customTabBar.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor),
			self.customTabBar.widthAnchor.constraint(equalToConstant: tabBar.frame.width),
			self.customTabBar.heightAnchor.constraint(equalToConstant: self.tabBarHeight)
		])

		menuItems.forEach { viewControllers.append($0.viewController) }
		self.viewControllers = viewControllers
		self.view.layoutIfNeeded()
	}

	func changeTab(index: Int) {
		self.selectedIndex = index
	}
}

extension BaseTabBarViewController: TabNavigationMenuDelegate {
	func itemTapped(tabIndex: Int) {
		changeTab(index: tabIndex)
	}
}
