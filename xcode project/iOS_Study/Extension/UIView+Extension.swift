//
//  UIView+Extension.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/06.
//

import UIKit

extension UIView {
	func fitSuperView() {
		guard let superView = superview else { return }
		self.translatesAutoresizingMaskIntoConstraints = false
		self.topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
		self.bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
		self.leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
		self.trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
	}

	func fitView(at target: UIView, leading: CGFloat, trailing: CGFloat, top: CGFloat, bottom: CGFloat) {
		self.translatesAutoresizingMaskIntoConstraints = false
		self.topAnchor.constraint(equalTo: target.topAnchor, constant: top).isActive = true
		self.bottomAnchor.constraint(equalTo: target.bottomAnchor, constant: bottom).isActive = true
		self.leadingAnchor.constraint(equalTo: target.leadingAnchor, constant: leading).isActive = true
		self.trailingAnchor.constraint(equalTo: target.trailingAnchor, constant: trailing).isActive = true
	}
}
