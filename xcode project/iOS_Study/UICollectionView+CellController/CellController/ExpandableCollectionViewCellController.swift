//
//  ExpandableCollectionViewCellController.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/13.
//

import Foundation

class ExpandableCollectionViewCellController: GenericCellController<ExpandableCollectionViewCell> {
	private var item: ExpandableCellModel

	init(item: ExpandableCellModel) {
		self.item = item
	}

	override func configureCell(_ cell: ExpandableCollectionViewCell) {
	}
}
