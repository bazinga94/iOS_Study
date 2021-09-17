//
//  ExpandableCollectionViewHeaderSectionController.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/15.
//

import UIKit

class ExpandableCollectionViewHeaderSectionController: GenericSectionController<ExpandableCollectionViewHeaderSection> {
	private var item: String

	init(item: String) {
		self.item = item
	}

	override func configureSection(_ section: ExpandableCollectionViewHeaderSection) {
		section.titleLabel.text = item
	}
}
