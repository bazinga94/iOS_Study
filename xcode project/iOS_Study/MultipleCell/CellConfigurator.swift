//
//  CellConfigurator.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/17.
//

import UIKit

protocol CellConfigurator {
	static var reuseId: String { get }
	func configure(cell: UIView)
}

class CollectionCellConfigurator<CellType: ConfigurableCell, DataType>: CellConfigurator where CellType.DataType == DataType, CellType: UICollectionViewCell {
	static var reuseId: String { return String(describing: CellType.self) }

	let item: DataType

	init(item: DataType) {
		self.item = item
	}

	func configure(cell: UIView) {
		(cell as! CellType).configure(data: item)
	}
}
