//
//  ExpandableCollectionViewCellController.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/13.
//

import UIKit

class ExpandableCollectionViewCellController: GenericCellController<ExpandableCollectionViewCell> {
	private var item: [ExpandableCellModel]
	weak var delegate: SectionReloadDelegate?

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
//			cell.sectionDelegate = sectionController
		}
		cell.delegate = delegate
		cell.sectionItems = sectionItems
	}

	override func cellHeight(availableWidth: CGFloat, _ cellHolder: UICollectionView, itemAt indexPath: IndexPath) -> CGFloat {
		guard let cell = cellHolder.dequeueReusableCell(withReuseIdentifier: type(of: self).cellIdentifier, for: indexPath) as? ExpandableCollectionViewCell else { return 0 }
		configureCell(cell)
		cell.tableView.reloadData()
		cell.layoutIfNeeded()

		return cell.tableView.contentSize.height
	}
}
