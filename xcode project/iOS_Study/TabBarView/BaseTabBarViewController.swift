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
		let tabBarItems: [TabBarItem] = [BankingTab(), AssetTab(), BenefitTab()]

		self.setupCustomTabMenu(tabBarItems)

		self.selectedIndex = 0	// 초기 index는 0

//		let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
//		let blurEffectView = UIVisualEffectView(effect: blurEffect)
//		blurEffectView.frame = tabBar.bounds //view.bounds
//		blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//		self.view.addSubview(blurEffectView)
//		blurEffectView.frame = tabBar.frame
//		tabBar.backgroundColor = .clear
//		tabBar.isTranslucent = false
//		tabBar.barTintColor = .clear
//		tabBar.backgroundImage = UIImage()
//		tabBar.isHidden = true
	}

	private func setupCustomTabMenu(_ menuItems: [TabBarItem]) {
		let frame = tabBar.frame
		var viewControllers = [UIViewController]()

		tabBar.isHidden = true
		self.customTabBar = TabNavigationMenu(menuItems: menuItems, frame: frame)
		self.customTabBar.translatesAutoresizingMaskIntoConstraints = false
		self.customTabBar.clipsToBounds = true
		self.customTabBar.itemTapped = self.changeTab(tabIndex:)

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

	func changeTab(tabIndex: Int) {
		self.selectedIndex = tabIndex
	}
}

//extension BaseTabBarViewController: UITabBarControllerDelegate {
//	func tabbarcontroller
//}
