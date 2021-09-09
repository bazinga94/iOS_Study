//
//  FirstSectionTableViewCellFactory.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/06.
//

import UIKit

class FirstSectionTableViewCellFactory {
	func registerCells(on tableView: UITableView) {
		TodayTableViewCellController.registerCell(on: tableView)
	}

	func cellControllers(item: [String]) -> [TableCellController] {
		return item.map { TodayTableViewCellController(item: $0) }
	}
}
