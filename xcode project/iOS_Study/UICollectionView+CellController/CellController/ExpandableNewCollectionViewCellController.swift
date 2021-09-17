//
//  ExpandableNewCollectionViewCellController.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/15.
//

import UIKit

class ExpandableNewCollectionViewCellController: GenericCellController<ExpandableNewCollectionViewCell> {
	var item: String

	init(item: String) {
		self.item = item
	}

	override func configureCell(_ cell: ExpandableNewCollectionViewCell) {
		cell.titleLabel.text = item
	}

	override func cellWidth(availableHeight: CGFloat, _ cellHolder: UICollectionView, itemAt indexPath: IndexPath) -> CGFloat {
		return cellHolder.frame.width
	}

	override func cellHeight(availableWidth: CGFloat, _ cellHolder: UICollectionView, itemAt indexPath: IndexPath) -> CGFloat {
		return 60
	}
}
