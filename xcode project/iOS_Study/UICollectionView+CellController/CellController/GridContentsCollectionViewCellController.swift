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

	override func cellHeight(availableWidth: CGFloat, _ cellHolder: UICollectionView, itemAt indexPath: IndexPath) -> CGFloat {
		return 40
	}

	override func cellWidth(availableHeight: CGFloat, _ cellHolder: UICollectionView, itemAt indexPath: IndexPath) -> CGFloat {
		guard let cell = cellHolder.dequeueReusableCell(withReuseIdentifier: type(of: self).cellIdentifier, for: indexPath) as? GridContentsCollectionViewCell else { return 0 }
		configureCell(cell)
//		cell.frame = CGRect(x: 0, y: 0, width: 1000, height: availableHeight)
		let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height: availableHeight)
		return cell.contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .required).width
	}
}
