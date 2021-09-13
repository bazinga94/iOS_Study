//
//  BaseCollectionViewCellFactory.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/13.
//

import UIKit

class BaseCollectionViewCellFactory {
	func registerCells(on collectionView: UICollectionView) {
		ExpandableCollectionViewCellController.registerCell(on: collectionView)
		GridCollectionViewCellController.registerCell(on: collectionView)
		HorizontalCollectionViewCellController.registerCell(on: collectionView)
		TileCollectionViewCellController.registerCell(on: collectionView)
		BaseCollectionViewHeaderSectionController.registerSection(on: collectionView)
	}

	func makeCellControllers(by items: BaseCollectionModel) -> [SectionController<UICollectionView>] {
		let cellController = items.expandableCellModel.map { ExpandableCollectionViewCellController(item: $0) }
		let sectionController = BaseCollectionViewHeaderSectionController(item: "베이스 뷰 헤더")
		sectionController.collectionCellControllers = cellController
		return [sectionController]
	}
}
