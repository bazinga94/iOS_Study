//
//  InnerCollectionViewCellController.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/09.
//

import Foundation

class InnerCollectionViewCellController: GenericCellController<InnerCollectionViewCell> {
	private var item: [String]

	init(item: [String]) {
		self.item = item
	}

	override func configureCell(_ cell: InnerCollectionViewCell) {
		cell.cellController = InnerCollectionViewCellFactory().cellControllers(items: item)
	}
}
