//
//  SampleTableViewFactory.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/06.
//

import UIKit

class SampleTableViewFactory {
	func registerCells(on tableView: UITableView) {
		FirstSectionTableViewCellController.registerCell(on: tableView)
		SecondSectionTableViewCellController.registerCell(on: tableView)
	}

	func cellControllers(items: SampleTableModel) -> [[TableCellController]] {
		let first = items.firstModel.map {
			FirstSectionTableViewCellController(item: $0)
		}
//		let second = items.secondModel.map {
//			SecondInnerTableViewCellController(item: $0)
//		}
		let menu = SecondSectionTableViewCellController(item: items.menuModel)

		return [first, [menu]]
	}
}
