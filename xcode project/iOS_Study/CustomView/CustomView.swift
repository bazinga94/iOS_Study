//
//  CustomView.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/06/28.
//

import UIKit

@IBDesignable
class CustomView: UIView {

	// 참고: https://medium.com/a-day-of-a-programmer/xib%EB%A5%BC-%EC%82%AC%EC%9A%A9%ED%95%9C-uiview-custom-%EC%A0%9C%EB%8C%80%EB%A1%9C-%EC%9D%B4%ED%95%B4%ED%95%98%EA%B8%B0-348a9b789496

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
