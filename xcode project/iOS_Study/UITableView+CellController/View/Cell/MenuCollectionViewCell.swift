//
//  MenuCollectionViewCell.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/09.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {

	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var roundView: UIView!

	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		roundView.roundCorners(cornerRadius: roundView.bounds.width/2, byRoundingCorners: .allCorners)
	}
}
