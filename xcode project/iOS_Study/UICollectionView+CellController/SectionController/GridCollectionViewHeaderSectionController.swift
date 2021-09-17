//
//  GridCollectionViewHeaderSectionController.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/15.
//

import UIKit

class GridCollectionViewHeaderSectionController: GenericSectionController<GridCollectionViewHeaderSection> {
	// 모델 받자~
	override func configureSection(_ section: GridCollectionViewHeaderSection) {
		section.titleLabel.text = "Grid"
	}
}
