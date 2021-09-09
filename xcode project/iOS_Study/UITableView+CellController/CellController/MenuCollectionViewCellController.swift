//
//  MenuCollectionViewCellController.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/09.
//

import Foundation

class MenuCollectionViewCellController: GenericCellController<MenuCollectionViewCell> {
	private var item: String

	init(item: String) {
		self.item = item
	}

	override func configureCell(_ cell: MenuCollectionViewCell) {
		cell.titleLabel.text = item
	}
}
