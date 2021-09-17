//
//  ConfigurableCell.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/17.
//

// clone code: https://medium.com/chili-labs/configuring-multiple-cells-with-generics-in-swift-dcd5e209ba16

import UIKit

protocol ConfigurableCell {
	associatedtype DataType

	func configure(data: DataType)
}

struct Profile {
	var name: String
}

class ProfileCell: UICollectionViewCell, ConfigurableCell {

	func configure(data user: Profile) {

	}
}
