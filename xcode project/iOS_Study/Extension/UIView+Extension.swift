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

	func roundCorners(cornerRadius: CGFloat, byRoundingCorners: UIRectCorner) {
		if #available(iOS 11.0, *) {
			clipsToBounds = true
			layer.cornerRadius = cornerRadius
			layer.maskedCorners = CACornerMask(rawValue: byRoundingCorners.rawValue)
		} else {
			let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: byRoundingCorners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
			let maskLayer = CAShapeLayer()
			maskLayer.frame = self.bounds
			maskLayer.path = path.cgPath

			layer.mask = maskLayer
		}
	}
}
