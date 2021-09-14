//
//  ExpandableTableViewHeaderSection.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/14.
//

import UIKit

class ExpandableTableViewHeaderSection: UITableViewHeaderFooterView {

//	override func awakeFromNib() {
//		super.awakeFromNib()
//		// Initialization code
//	}
	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
