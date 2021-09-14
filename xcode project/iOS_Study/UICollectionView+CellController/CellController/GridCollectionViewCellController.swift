//
//  GridCollectionViewCellController.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/13.
//

import UIKit

class GridCollectionViewCellController: GenericCellController<GridCollectionViewCell> {
	private var item: [GridCellModel]

	init(item: [GridCellModel]) {
		self.item = item
	}

	override func configureCell(_ cell: GridCollectionViewCell) {
		// 우선 섹션 1개 기준으로 구현하자.. TODO 섹션 적용
		cell.cellControllers = item[0].list.map {
			GridContentsCollectionViewCellController(item: $0)
		}
	}

	override func cellHeight(_ cellHolder: UICollectionView, itemAt indexPath: IndexPath) -> CGFloat {
		guard let cell = cellHolder.dequeueReusableCell(withReuseIdentifier: type(of: self).cellIdentifier, for: indexPath) as? GridCollectionViewCell else { return 0 }
		configureCell(cell)
		cell.frame = CGRect(x: 0, y: 0, width: 1000, height: 1000)
		cell.collectionView.reloadData()
		cell.layoutIfNeeded()

		return cell.collectionView.contentSize.height
	}
}
