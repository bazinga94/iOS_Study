//
//  InnerTableViewCellController.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/06.
//

import UIKit

class FirstInnerTableViewCellController: GenericCellController<InnerTableViewCell> {
	private var item: FirstDummyModel

	init(item: FirstDummyModel) {
		self.item = item
	}

	override func configureCell(_ cell: InnerTableViewCell) {
		cell.titleLabel.text = item.title
		cell.backgroundColor = .yellow
		cell.viewModel = InnerTableViewCellViewModel(items: item.content)
		cell.viewModel.fetch()
	}
}

class SecondInnerTableViewCellController: GenericCellController<InnerTableViewCell> {
	private var item: SecondDummyModel

	init(item: SecondDummyModel) {
		self.item = item
	}

	override func configureCell(_ cell: InnerTableViewCell) {
		cell.titleLabel.text = "하드코딩~"
		cell.backgroundColor = .orange
		cell.viewModel = InnerTableViewCellViewModel(items: item.content)
		cell.viewModel.fetch()
	}
}
