//
//  SecondSectionTableViewCellFactory.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/09.
//

import UIKit

class SecondSectionTableViewCellFactory {
	func registerCells(on collectionView: UICollectionView) {
		MenuCollectionViewCellController.registerCell(on: collectionView)
	}

	func cellControllers(items: [String]) -> [CollectionCellController] {
		return items.map { MenuCollectionViewCellController(item: $0) }
	}
}
