//
//  ExpandableCollectionViewCellController.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/13.
//

import UIKit

class ExpandableCollectionViewCellController: GenericCellController<ExpandableCollectionViewCell> {
	private var item: [ExpandableCellModel]

	init(item: [ExpandableCellModel]) {
		self.item = item
	}

	override func configureCell(_ cell: ExpandableCollectionViewCell) {
		var sectionItems: [SectionController<UITableView>] = []

		for model in item {
			let cellControllers = model.list.map { ExpandableTableViewCellController(item: $0) }
			let sectionController = ExpandableTableViewSectionController(item: model.headerTitle)
			sectionController.tableCellControllers = cellControllers
			sectionItems.append(sectionController)
		}

		cell.sectionItems = sectionItems
	}
}
