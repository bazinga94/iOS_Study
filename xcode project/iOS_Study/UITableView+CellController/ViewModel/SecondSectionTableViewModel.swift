//
//  SecondSectionTableViewModel.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/10.
//

import Foundation

class SecondSectionTableViewModel {

	private var menuList: [String]
	var sampleCollectionModel: Dynamic<[String]> = .init([])

	init(menuList: [String]) {
		self.menuList = menuList
	}

	func fetchAllMenuData() {
		sampleCollectionModel.value = menuList
	}

	func deleteMenuData() {
		sampleCollectionModel.value = menuList[0..<5].map { $0 }
	}
}
