//
//  TodayTableViewCellController.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/06.
//

import UIKit

class TodayTableViewCellController: GenericCellController<TodayTableViewCell> {
	private var item: String

	init(item: String) {
		self.item = item
	}

	override func configureCell(_ cell: TodayTableViewCell) {
		cell.titleLabel.text = item
	}
}
