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
				FirstDummyModel(title: "4", content: ["4-1", "4-2", "4-3"])
			], secondModel: [
				SecondDummyModel(content: ["무", "야", "호"]),
				SecondDummyModel(content: ["~", "!"])
			])

		cellControllers.value = factory.cellControllers(items: sampleTableModel)
	}
}
