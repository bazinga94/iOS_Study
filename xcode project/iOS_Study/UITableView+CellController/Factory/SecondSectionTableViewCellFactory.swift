//
//  SecondSectionTableViewCellFactory.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/09.
//

import UIKit

class SecondSectionTableViewCellFactory {
//	private var items: [String]
//
//	init(items: [String]) {
//		self.items = items
//	}

	func registerCells(on collectionView: UICollectionView) {
		MenuCollectionViewCellController.registerCell(on: collectionView)
	}

	func cellControllers(items: [String]) -> [CollectionCellController] {
		return items.map { MenuCollectionViewCellController(item: $0) }
	}

//	func deleteCellControllers() -> [CollectionCellController] {
//		return self.items[0..<5].map { MenuCollectionViewCellController(item: $0) }
//	}
//
//	func originalCellControllers() -> [CollectionCellController] {
//		return self.items.map { MenuCollectionViewCellController(item: $0) }
//	}
}
