//
//  BottomTabNavigationMenu.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/08/24.
//

import UIKit
import Lottie

protocol BottomTabNavigationMenuDelegate: class {
	func itemTapped(tabIndex: Int)
}

class BottomTabNavigationMenu: UIView {
	var activeItem: Int = 0
	let iconViewHeight: CGFloat = 40
	weak var delegate: BottomTabNavigationMenuDelegate?

	override init(frame: CGRect) {
		super.init(frame: frame)
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	convenience init(menuItems: [BottomTabBarItem], frame: CGRect) {
		self.init(frame: frame)

		let itemWidth = self.frame.width / CGFloat(menuItems.count)

		for (idx, menuItem) in menuItems.enumerated() {
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
			self.activateTab(index: 0)	// 첫번째 tab
		}

		backgroundColor = .clear
	}

	private func createTabItemView(item: BottomTabBarItem) -> UIView {
		let tabItemView = UIView(frame: .zero)
		let tabItemLabel = UILabel(frame: .zero)
//		let tabItemIconView = UIImageView(frame: .zero)
		let tabItemIconView = item.lottieView

		tabItemView.tag = 11
		tabItemLabel.tag = 12
		tabItemIconView.tag = 13

		tabItemLabel.text = item.type.rawValue
		tabItemLabel.textColor = .lightGray
		tabItemLabel.textAlignment = .center
		tabItemLabel.translatesAutoresizingMaskIntoConstraints = false
		tabItemLabel.clipsToBounds = true

//		tabItemIconView.image = item.iconImage.withRenderingMode(.automatic)	// 이거 머지??
//		tabItemIconView.image = item.iconImage
		tabItemIconView.loopMode = .playOnce
		tabItemIconView.contentMode = .scaleAspectFill
//		tabItemIconView.frame = .init()
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
		self.deactivateTab(index: from)
		self.activateTab(index: to)
	}

	func activateTab(index: Int) {
		let activateTabView = self.subviews[index]
		let label = activateTabView.viewWithTag(12) as? UILabel
		let lottie = activateTabView.viewWithTag(13) as? AnimationView

		DispatchQueue.main.async {
			label?.textColor = .black
			lottie?.play()
		}
		self.activeItem = index
		self.delegate?.itemTapped(tabIndex: index)
	}

	func deactivateTab(index: Int) {
		let activateTabView = self.subviews[index]
		let label = activateTabView.viewWithTag(12) as? UILabel
		let lottie = activateTabView.viewWithTag(13) as? AnimationView

		DispatchQueue.main.async {
			label?.textColor = .lightGray
			lottie?.stop()
		}
	}
}
