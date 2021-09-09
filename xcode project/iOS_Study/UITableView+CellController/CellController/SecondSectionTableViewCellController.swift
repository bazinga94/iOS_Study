//
//  SecondSectionTableViewCellController.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/09.
//

import Foundation

class SecondSectionTableViewCellController: GenericCellController<SecondSectionTableViewCell> {
	private var item: [String]

	init(item: [String]) {
		self.item = item
	}

	override func configureCell(_ cell: SecondSectionTableViewCell) {
		cell.cellControllers = SecondSectionTableViewCellFactory().cellControllers(items: item)
	}
}
