//
//  TopTabNavigationMenu.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/08/26.
//

import UIKit

protocol TopTabNavigationMenuDelegate: class {
	func itemTapped(tabIndex: Int)
}

class TopTabNavigationMenu: UIView {
	var activeItem: Int = 0
	weak var delegate: TopTabNavigationMenuDelegate?

	override init(frame: CGRect) {
		super.init(frame: frame)
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	convenience init(menuItems: [TopTabBarItem], frame: CGRect) {
		self.init(frame: frame)

		for (idx, menuItem) in menuItems.enumerated() {

			let fontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
			let labelSize = menuItem.title.size(withAttributes: fontAttributes)
			let tabWidth = labelSize.width + 10	// 양쪽 간격 10

			let itemLeadingAnchor = tabWidth * CGFloat(idx)

			let itemView = createTabItemView(item: menuItem)
			itemView.translatesAutoresizingMaskIntoConstraints = false
			itemView.clipsToBounds = true
			itemView.tag = idx

			self.addSubview(itemView)

			NSLayoutConstraint.activate([
				itemView.heightAnchor.constraint(equalTo: self.heightAnchor),
				itemView.widthAnchor.constraint(equalToConstant: tabWidth),
				itemView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: itemLeadingAnchor),
				itemView.topAnchor.constraint(equalTo: self.topAnchor)
			])

			self.setNeedsLayout()
			self.activateTab(index: 0)	// 첫번째 tab
		}

		backgroundColor = .white
	}

	private func createTabItemView(item: TopTabBarItem) -> UIView {
		let tabItemView = UIView(frame: .zero)
		let tabItemLabel = UILabel(frame: .zero)

		tabItemView.tag = 11
		tabItemLabel.tag = 12

		tabItemLabel.text = item.title
		tabItemLabel.textColor = .lightGray
		tabItemLabel.textAlignment = .center
		tabItemLabel.translatesAutoresizingMaskIntoConstraints = false
		tabItemLabel.clipsToBounds = true

		tabItemView.backgroundColor = .clear
		tabItemView.addSubview(tabItemLabel)
		tabItemView.translatesAutoresizingMaskIntoConstraints = false
		tabItemView.clipsToBounds = true

		NSLayoutConstraint.activate([
			tabItemLabel.heightAnchor.constraint(equalToConstant: 15),
			tabItemLabel.centerXAnchor.constraint(equalTo: tabItemView.centerXAnchor),
			tabItemLabel.topAnchor.constraint(equalTo: tabItemView.topAnchor, constant: 5)
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

		DispatchQueue.main.async {
			label?.textColor = .black
		}
		self.activeItem = index
		self.delegate?.itemTapped(tabIndex: index)
	}

	func deactivateTab(index: Int) {
		let activateTabView = self.subviews[index]
		let label = activateTabView.viewWithTag(12) as? UILabel

		DispatchQueue.main.async {
			label?.textColor = .lightGray
		}
	}
}
