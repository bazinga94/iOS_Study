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
//		cell.viewModel = InnerTableViewCellViewModel(items: item.content)
//		cell.viewModel.fetch()
	}
}

//class SecondInnerTableViewCellController: GenericCellController<FirstSectionTableViewCell> {
//	private var item: SecondDummyModel
//
//	init(item: SecondDummyModel) {
//		self.item = item
//	}
//
//	override func configureCell(_ cell: FirstSectionTableViewCell) {
//		cell.titleLabel.text = "하드코딩~"
//		cell.backgroundColor = .orange
//		cell.cellControllers = InnerTableViewCellFactory().cellControllers(item: item.content)
////		cell.viewModel = InnerTableViewCellViewModel(items: item.content)
////		cell.viewModel.fetch()
//	}
//}
