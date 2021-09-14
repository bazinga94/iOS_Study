//
//  ExpandableTableViewCellController.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/14.
//

import UIKit

class ExpandableTableViewCellController: GenericCellController<ExpandableTableViewCell> {
	private var item: String

	init(item: String) {
		self.item = item
	}

	override func configureCell(_ cell: ExpandableTableViewCell) {
		cell.titleLabel.text = item
	}
}
