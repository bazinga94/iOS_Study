//
//  AssetInnerViewController.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/08/26.
//

import UIKit

class AssetInnerViewController: UITabBarController {
	var customTabBar: TopTabNavigationMenu!
	var tabBarHeight: CGFloat = 60.0

	override func viewDidLoad() {
		super.viewDidLoad()
		self.loadTabBar()
	}

	private func loadTabBar() {
		tabBar.isHidden = true
		let tabBarItems: [TopTabBarItem] = [FirstTopTab(), SecondTopTab()]		// tab을 추가하고 싶으면 여기에 Item을 추가하면 된다.
		self.setupCustomTabMenu(tabBarItems)
		self.selectedIndex = 0	// 초기 index는 0
	}

	private func setupCustomTabMenu(_ menuItems: [TopTabBarItem]) {
		let frame = tabBar.frame
		var viewControllers = [UIViewController]()

		self.customTabBar = TopTabNavigationMenu(menuItems: menuItems, frame: frame)
		self.customTabBar.translatesAutoresizingMaskIntoConstraints = false
		self.customTabBar.clipsToBounds = true
		self.customTabBar.delegate = self
		self.view.addSubview(customTabBar)

		NSLayoutConstraint.activate([
			self.customTabBar.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
			self.customTabBar.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
			self.customTabBar.topAnchor.constraint(equalTo: self.view.topAnchor),
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

extension AssetInnerViewController: TopTabNavigationMenuDelegate {
	func itemTapped(tabIndex: Int) {
		changeTab(index: tabIndex)
	}
}

extension AssetInnerViewController: TabBarAnimatable {
	func animateTabBar(hidden: Bool) {

	}
}
