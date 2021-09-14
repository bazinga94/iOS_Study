//
//  ExpandableTableViewSectionController.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/14.
//

import UIKit

protocol ExpandableTableViewSectionDelegate: class {
	func sectionTap()
}

class ExpandableTableViewSectionController: GenericSectionController<ExpandableTableViewHeaderSection> {
	private var item: String
	private var isExpanded: Bool = true
	weak var delegate: ExpandableTableViewSectionDelegate?

	init(item: String) {
		self.item = item
	}

	override func configureSection(_ section: ExpandableTableViewHeaderSection) {
		let backgroundView = UIView(frame: section.bounds)
		backgroundView.backgroundColor = .blue
		section.backgroundView = backgroundView
//		section.sectionButton.addTarget(nil, action: #selector(hideSection(button:)), for: .touchUpInside)
	}

//	@objc func hideSection(button: UIButton) {
//		isExpanded = !isExpanded
//		delegate?.sectionTap()
//	}
}
