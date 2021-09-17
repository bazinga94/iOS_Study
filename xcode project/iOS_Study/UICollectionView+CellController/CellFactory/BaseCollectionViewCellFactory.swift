//
//  BaseCollectionViewCellFactory.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/13.
//

import UIKit

class BaseCollectionViewCellFactory {
	func registerCells(on collectionView: UICollectionView) {
//		ExpandableCollectionViewCellController.registerCell(on: collectionView)
//		GridCollectionViewCellController.registerCell(on: collectionView)
//		HorizontalCollectionViewCellController.registerCell(on: collectionView)
//		TileCollectionViewCellController.registerCell(on: collectionView)
//		BaseCollectionViewHeaderSectionController.registerSection(on: collectionView)

		ExpandableCollectionViewHeaderSectionController.registerSection(on: collectionView)
		ExpandableNewCollectionViewCellController.registerCell(on: collectionView)
		GridCollectionViewHeaderSectionController.registerSection(on: collectionView)
		GridContentsCollectionViewCellController.registerCell(on: collectionView)
	}

	func makeCellControllers(by items: BaseCollectionModel, delegate: SectionReloadDelegate) -> [SectionController<UICollectionView>] {
		var expandableSectionControllers: [SectionController<UICollectionView>] = []

		for item in items.expandableCellModel {
			let sectionController = ExpandableCollectionViewHeaderSectionController(item: item.headerTitle)
			let cellControllers = item.list.map {
				ExpandableNewCollectionViewCellController(item: $0)
			}
			sectionController.collectionCellControllers = cellControllers
			expandableSectionControllers.append(sectionController)
		}
//		let expandableCellControllers = ExpandableCollectionViewCellController(item: items.expandableCellModel)
//		expandableCellControllers.delegate = delegate
//		let sectionController = BaseCollectionViewHeaderSectionController(item: "베이스 뷰 헤더")

		var gridSectionControllers: [SectionController<UICollectionView>] = []

		for item in items.gridCellModel {
			let sectionController = GridCollectionViewHeaderSectionController()
			let cellControllers = item.list.map {
				GridContentsCollectionViewCellController(item: $0)
			}
			sectionController.collectionCellControllers = cellControllers
			gridSectionControllers.append(sectionController)
		}

		return expandableSectionControllers + gridSectionControllers
	}
}
