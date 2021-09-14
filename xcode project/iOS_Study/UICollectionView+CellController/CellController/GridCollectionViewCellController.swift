//
//  GridCollectionViewCellController.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/13.
//

import Foundation

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
}
