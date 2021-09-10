//
//  SecondSectionTableViewCellController.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/09.
//

import Foundation

class SecondSectionTableViewCellController: GenericCellController<SecondSectionTableViewCell> {
	private var item: [String]
	private var delegate: SecondSectionTableViewCellDelegate

	init(item: [String], delegate: SecondSectionTableViewCellDelegate) {
		self.item = item
		self.delegate = delegate
	}

	override func configureCell(_ cell: SecondSectionTableViewCell) {
//		cell.factory = SecondSectionTableViewCellFactory(items: item)
		cell.delegate = delegate
		cell.viewModel = SecondSectionTableViewModel(menuList: item)
		cell.cellControllers = SecondSectionTableViewCellFactory().cellControllers(items: item)
		cell.layoutIfNeeded()
	}
}
