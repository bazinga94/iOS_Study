//
//  BaseCollectionViewHeaderSectionController.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/13.
//

import UIKit

class BaseCollectionViewHeaderSectionController: GenericSectionController<BaseCollectionViewHeaderSection> {

	var item: String

	init(item: String) {
		self.item = item
	}

	override func configureSection(_ section: BaseCollectionViewHeaderSection) {
		section.headerTitle.text = item
	}
}
