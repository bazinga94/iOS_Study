//
//  BaseTabBarViewController.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/08/24.
//

import UIKit

protocol TabBarAnimatable {
	func animateTabBar(hidden: Bool)
}

class BaseTabBarViewController: UITabBarController {
	var customTabBar: BottomTabNavigationMenu!
	var topConstraint: NSLayoutConstraint = NSLayoutConstraint.init()
	var tabBarHeight: CGFloat = 120.0

	override func viewDidLoad() {
		super.viewDidLoad()
		self.loadTabBar()
		self.loadFloatingButton()
	}

	private func loadFloatingButton() {
		let floatingButton = FloatingButton(frame: CGRect(x: 330, y: 660, width: 30, height: 30))
		floatingButton.backgroundColor = .red
		self.view.addSubview(floatingButton)
	}

	private func loadTabBar() {
		tabBar.isHidden = true
		let tabBarItems: [BottomTabBarItem] = [BankingTab(), AssetTab(), BenefitTab()]		// tab을 추가하고 싶으면 여기에 Item을 추가하면 된다.
		self.setupCustomTabMenu(tabBarItems)
		self.setupBlurEffectView()
		self.selectedIndex = 0	// 초기 index는 0
	}

	private func setupBlurEffectView() {
		let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
		let blurEffectView = UIVisualEffectView(effect: blurEffect)
		blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		blurEffectView.translatesAutoresizingMaskIntoConstraints = false
		blurEffectView.clipsToBounds = true
		self.view.insertSubview(blurEffectView, belowSubview: customTabBar)

		NSLayoutConstraint.activate([
			blurEffectView.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
			blurEffectView.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
			blurEffectView.topAnchor.constraint(equalTo: self.customTabBar.topAnchor),
			blurEffectView.heightAnchor.constraint(equalToConstant: self.tabBarHeight)
		])
	}

	private func setupCustomTabMenu(_ menuItems: [BottomTabBarItem]) {
		let frame = tabBar.frame
		var viewControllers = [UIViewController]()

		self.customTabBar = BottomTabNavigationMenu(menuItems: menuItems, frame: frame)
		self.customTabBar.translatesAutoresizingMaskIntoConstraints = false
		self.customTabBar.clipsToBounds = true
		self.customTabBar.delegate = self
		self.view.addSubview(customTabBar)

		self.topConstraint = self.customTabBar.topAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -self.tabBarHeight)

		NSLayoutConstraint.activate([
			self.customTabBar.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
			self.customTabBar.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
			self.topConstraint,
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

extension BaseTabBarViewController: BottomTabNavigationMenuDelegate {
	func itemTapped(tabIndex: Int) {
		changeTab(index: tabIndex)
	}
}

extension BaseTabBarViewController: TabBarAnimatable {
	func animateTabBar(hidden: Bool) {
		self.topConstraint.constant = (hidden) ? 0 : -self.tabBarHeight

		UIView.animate(withDuration: 0.2) {
			self.view.layoutIfNeeded()
		}
	}
}
