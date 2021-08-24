//
//  TabNavigationMenu.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/08/24.
//

import UIKit

class TabNavigationMenu: UIView {
	var itemTapped: ((_ tab: Int) -> Void)?
	var activeItem: Int = 0

	override init(frame: CGRect) {
		super.init(frame: frame)
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	convenience init(menuItems: [TabBarItem], frame: CGRect) {
		self.init(frame: frame)
		// ...
	}

	func createTabItem(item: TabBarItem) {
		// ...
	}

	@objc func handleTap(_ sender: UIGestureRecognizer) {
		// ...
	}

	func switchTab(from: Int, to: Int) {
		// ...
	}

	func activateTab(tab: Int) {
		// ...
	}

	func deactivateTab(tab: Int) {
		// ...
	}
}
