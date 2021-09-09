//
//  InnerTableViewCellViewModel.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/06.
//

import Foundation

class InnerTableViewCellViewModel {

	private var items: [String]
	private let factory = InnerTableViewCellFactory()

	var cellControllers: Dynamic<[TableCellController]> = .init([])

	init(items: [String]) {
		self.items = items
	}

	func fetch() {
		cellControllers.value = factory.cellControllers(item: items)
	}
}
