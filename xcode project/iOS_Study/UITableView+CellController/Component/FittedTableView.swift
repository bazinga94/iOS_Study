//
//  FittedTableView.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/09.
//

import UIKit

class FittedTableView: UITableView {
//	override var intrinsicContentSize: CGSize {
//		print(contentSize)
//		return contentSize
//	}
//	override var contentSize:CGSize {
//		didSet {
//			invalidateIntrinsicContentSize()
//		}
//	}
//
//	override var intrinsicContentSize: CGSize {
//		layoutIfNeeded()
//		return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
//	}
	override var intrinsicContentSize: CGSize {
		self.layoutIfNeeded()
		return self.contentSize
	}

	override var contentSize: CGSize {
		didSet{
			self.invalidateIntrinsicContentSize()
		}
	}

	override func reloadData() {
		super.reloadData()
		self.invalidateIntrinsicContentSize()
	}
}
