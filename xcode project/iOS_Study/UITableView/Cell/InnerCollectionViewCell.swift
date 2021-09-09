//
//  InnerCollectionViewCell.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/09.
//

import UIKit

class InnerCollectionViewCell: UITableViewCell {

	@IBOutlet weak var collectionView: UICollectionView!

	let factory = InnerCollectionViewCellFactory()
	var cellController: [CollectionCellController] = []

	override func awakeFromNib() {
		super.awakeFromNib()
		factory.registerCells(on: collectionView)
		collectionView.dataSource = self
		// Initialization code
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		// Configure the view for the selected state
	}
}

extension InnerCollectionViewCell: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return cellController.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		return cellController[indexPath.row].cellFromReusableCellHolder(collectionView, forIndexPath: indexPath)
	}
}
