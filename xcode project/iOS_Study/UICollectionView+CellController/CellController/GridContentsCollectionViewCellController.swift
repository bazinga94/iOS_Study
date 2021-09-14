//
//  GridContentsCollectionViewCellController.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/14.
//

import UIKit

class GridContentsCollectionViewCellController: GenericCellController<GridContentsCollectionViewCell> {
	private var item: String

	init(item: String) {
		self.item = item
	}

	override func configureCell(_ cell: GridContentsCollectionViewCell) {
		cell.titleLabel.text = item
	}
}
