//
//  SampleTableViewModel.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/06.
//

import Foundation

class SampleTableViewModel {
	private let factory = SampleTableViewFactory()

	var cellControllers: Dynamic<[[TableCellController]]> = .init([])

	func fetchDummyData() {
		let sampleTableModel =
			SampleTableModel.init(firstModel: [
				FirstDummyModel(title: "1", content: ["1-1", "1-2", "1-3"]),
				FirstDummyModel(title: "2", content: ["2-1", "2-2", "2-3"]),
				FirstDummyModel(title: "3", content: ["3-1", "3-2", "3-3"]),
				FirstDummyModel(title: "4", content: ["4-1", "4-2", "4-3"]),
				FirstDummyModel(title: "5", content: ["5-1", "5-2", "5-3"]),
				FirstDummyModel(title: "6", content: ["6-1", "6-2", "6-3"]),
				FirstDummyModel(title: "7", content: ["7-1", "7-2", "7-3"]),
				FirstDummyModel(title: "8", content: ["8-1", "8-2", "8-3"]),
				FirstDummyModel(title: "9", content: ["9-1", "9-2", "9-3"]),
			], secondModel: [
				SecondDummyModel(content: ["무", "야", "호"]),
				SecondDummyModel(content: ["~", "!"])
			])

		cellControllers.value = factory.cellControllers(items: sampleTableModel)
	}
}
