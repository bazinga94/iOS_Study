//
//  InnerTableViewCellController.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/06.
//

import UIKit

class FirstSectionTableViewCellController: GenericCellController<FirstSectionTableViewCell> {
	private var item: FirstDummyModel

	init(item: FirstDummyModel) {
		self.item = item
	}

	override func configureCell(_ cell: FirstSectionTableViewCell) {
		cell.titleLabel.text = item.title
		cell.backgroundColor = .yellow
		cell.cellControllers = FirstSectionTableViewCellFactory().cellControllers(item: item.content)
	}
}
