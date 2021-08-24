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
	let iconViewHeight: CGFloat = 30

	override init(frame: CGRect) {
		super.init(frame: frame)
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	convenience init(menuItems: [TabBarItem], frame: CGRect) {
		self.init(frame: frame)

		for (idx, menuItem) in menuItems.enumerated() {
			let itemWidth = self.frame.width / CGFloat(menuItems.count)
			let itemLeadingAnchor = itemWidth * CGFloat(idx)

			let itemView = createTabItemView(item: menuItem)
			itemView.translatesAutoresizingMaskIntoConstraints = false
			itemView.clipsToBounds = true
			itemView.tag = idx

			self.addSubview(itemView)

			NSLayoutConstraint.activate([
				itemView.heightAnchor.constraint(equalTo: self.heightAnchor),
				itemView.widthAnchor.constraint(equalToConstant: itemWidth),
				itemView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: itemLeadingAnchor),
				itemView.topAnchor.constraint(equalTo: self.topAnchor)
			])

			self.setNeedsLayout()
			self.activateTab(tab: 0)	// 첫번째 tab
		}

//		backgroundColor = .clear
//		let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
//		let blurEffectView = UIVisualEffectView(effect: blurEffect)
//		blurEffectView.frame = self.bounds
//		blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//		self.addSubview(blurEffectView)
	}

	private func createTabItemView(item: TabBarItem) -> UIView {
		let tabItemView = UIView(frame: .zero)
		let tabItemLabel = UILabel(frame: .zero)
		let tabItemIconView = UIImageView(frame: .zero)

		tabItemView.tag = 11
		tabItemLabel.tag = 12
		tabItemIconView.tag = 13

		tabItemLabel.text = item.type.rawValue
		tabItemLabel.textColor = .lightGray
		tabItemLabel.textAlignment = .center
		tabItemLabel.translatesAutoresizingMaskIntoConstraints = false
		tabItemLabel.clipsToBounds = true

//		tabItemIconView.image = item.iconImage.withRenderingMode(.automatic)	// 이거 머지??
		tabItemIconView.image = item.iconImage
		tabItemIconView.translatesAutoresizingMaskIntoConstraints = false
		tabItemIconView.clipsToBounds = true

		tabItemView.backgroundColor = .clear
		tabItemView.addSubview(tabItemLabel)
		tabItemView.addSubview(tabItemIconView)
		tabItemView.translatesAutoresizingMaskIntoConstraints = false
		tabItemView.clipsToBounds = true

		NSLayoutConstraint.activate([
			tabItemIconView.heightAnchor.constraint(equalToConstant: self.iconViewHeight),
			tabItemIconView.widthAnchor.constraint(equalToConstant: self.iconViewHeight),
			tabItemIconView.centerXAnchor.constraint(equalTo: tabItemView.centerXAnchor),
			tabItemIconView.topAnchor.constraint(equalTo: tabItemView.topAnchor, constant: 8),

			tabItemLabel.heightAnchor.constraint(equalToConstant: 15),
			tabItemLabel.centerXAnchor.constraint(equalTo: tabItemView.centerXAnchor),
			tabItemLabel.topAnchor.constraint(equalTo: tabItemIconView.bottomAnchor, constant: 4)
		])

		tabItemView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:))))

		return tabItemView
	}

	@objc func handleTap(_ sender: UIGestureRecognizer) {
		self.switchTab(from: self.activeItem, to: sender.view!.tag)
	}

	func switchTab(from: Int, to: Int) {
		self.deactivateTab(tab: from)
		self.activateTab(tab: to)
	}

	func activateTab(tab: Int) {
		let activateTabView = self.subviews[tab]
		let label = activateTabView.viewWithTag(12) as? UILabel

		DispatchQueue.main.async {
			label?.textColor = .black
		}
		self.activeItem = tab
	}

	func deactivateTab(tab: Int) {
		let activateTabView = self.subviews[tab]
		let label = activateTabView.viewWithTag(12) as? UILabel

		DispatchQueue.main.async {
			label?.textColor = .lightGray
		}
	}
}
