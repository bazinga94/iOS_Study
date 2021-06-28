//
//  CustomView.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/06/28.
//

import UIKit

@IBDesignable
class CustomView: UIView {

	// MARK: - 방식 1
//	override init(frame: CGRect) {
//		super.init(frame: frame)
//		let name = String(describing: type(of: self))
//		guard let loadedNib = Bundle.main.loadNibNamed(name, owner: self, options: nil) else { return }
//		guard let view = loadedNib.first as? UIView else { return }
//		view.frame = self.bounds
//		view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//		self.addSubview(view)
//	}

	// MARK: - 방식 2
//	override init(frame: CGRect) {
//		super.init(frame: frame)
//		let name = String(describing: type(of: self))
//		let nib = UINib(nibName: name, bundle: Bundle.main)
//		guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
//			return }
//		view.frame = self.bounds
//		view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//		self.addSubview(view)
//	}

//	required init?(coder: NSCoder) {
//		super.init(coder: coder)
//		fatalError("init(coder:) has not been implemented")
//	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}

	private func commonInit() {
		let name = String(describing: type(of: self))
//		guard let loadedNib = Bundle.main.loadNibNamed(name, owner: self, options: nil) else { return }	// 이렇게 하면 rendering fail 발생!! https://stackoverflow.com/a/56128426
//		guard let view = loadedNib.first as? UIView else { return }
		let bundle = Bundle(for: type(of: self))
		bundle.loadNibNamed(name, owner: self, options: nil)
		guard let view = bundle.loadNibNamed(name, owner: self, options: nil)?.first as? UIView else { return }
		view.frame = self.bounds
		view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		self.addSubview(view)
	}
}
