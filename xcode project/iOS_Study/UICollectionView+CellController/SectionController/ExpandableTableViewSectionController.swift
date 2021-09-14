//
//  ExpandableTableViewSectionController.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/14.
//

import UIKit

class ExpandableTableViewSectionController: GenericSectionController<ExpandableTableViewHeaderSection> {
	private var item: String

	init(item: String) {
		self.item = item
	}

	override func configureSection(_ section: ExpandableTableViewHeaderSection) {
		section.contentView.backgroundColor = .blue
	}
}
