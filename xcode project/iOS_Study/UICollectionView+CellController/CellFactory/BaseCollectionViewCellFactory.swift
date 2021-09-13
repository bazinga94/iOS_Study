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
	}

	func makeCellControllers(by items: BaseCollectionModel) -> [CollectionCellController] {
		let cellController = items.expandableCellModel.map { ExpandableCollectionViewCellController(item: $0) }
		return cellController
	}
}
