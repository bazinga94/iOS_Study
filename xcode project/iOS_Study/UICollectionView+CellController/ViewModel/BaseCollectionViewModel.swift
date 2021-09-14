//
//  BaseCollectionViewModel.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/13.
//

import Foundation

struct BaseCollectionModel {
	var expandableCellModel: [ExpandableCellModel]
	var gridCellModel: [GridCellModel]
	var horizontalModel: [HorizontalModel]
	var tileCellModel: [TileCellModel]
}

struct ExpandableCellModel {
	var headerTitle: String
	var list: [String]
}

struct GridCellModel {
	var headerTitle: String
	var list: [String]
}

struct HorizontalModel {
	struct CellModel {
		var title: String
		var content: String
	}
	var list: [CellModel]
}

struct TileCellModel {
	struct CellModel {
		var title: String
		var content: String
	}
	var list: [CellModel]
}



class BaseCollectionViewModel {
	var baseCollectionModel: Dynamic<BaseCollectionModel> = .init(BaseCollectionModel(expandableCellModel: [], gridCellModel: [], horizontalModel: [], tileCellModel: []))

	func fetch() {
		baseCollectionModel.value = BaseCollectionModel(
			expandableCellModel: [ExpandableCellModel(
				headerTitle: "Expandable",
				list: ["1", "2", "3", "4"]
			), ExpandableCellModel(
				headerTitle: "Expandable",
				list: ["1", "2", "3"]
			), ExpandableCellModel(
				headerTitle: "Expandable",
				list: ["1", "2"]
			)],
			gridCellModel: [GridCellModel(
				headerTitle: "Gird",
				list: ["1", "2", "3", "4", "5"]
			)],
			horizontalModel: [HorizontalModel(
				list: [HorizontalModel.CellModel(title: "a", content: "aa"),
					   HorizontalModel.CellModel(title: "b", content: "bb")
					   ]
			)],
			tileCellModel: [TileCellModel(
				list: [TileCellModel.CellModel(title: "A", content: "AA"),
					   TileCellModel.CellModel(title: "B", content: "BB")
				]
			)]
		)
	}
}
