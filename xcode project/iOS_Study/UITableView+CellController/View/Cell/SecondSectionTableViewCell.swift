//
//  SecondSectionTableViewCell.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/09.
//

import UIKit

class SecondSectionTableViewCell: UITableViewCell {

	enum Constant {
		static let inset: CGFloat = 20
		static let minimumLineSpacing: CGFloat = 20
		static let minimumInteritemSpacing: CGFloat = 10
		static let cellsPerRow = 5
	}

	@IBOutlet weak var collectionView: FittedCollectionView!

	private let factory = SecondSectionTableViewCellFactory()
	var cellControllers: [CollectionCellController] = []

	override func awakeFromNib() {
		super.awakeFromNib()
		factory.registerCells(on: collectionView)
		collectionView.dataSource = self
		collectionView.delegate = self
		// Initialization code
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		collectionView.reloadData()
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		// Configure the view for the selected state
	}
}

extension SecondSectionTableViewCell: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return cellControllers.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		return cellControllers[indexPath.row].cellFromReusableCellHolder(collectionView, forIndexPath: indexPath)
	}
}

extension SecondSectionTableViewCell: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: Constant.inset, left: Constant.inset, bottom: Constant.inset, right: Constant.inset)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return Constant.minimumLineSpacing
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return Constant.minimumInteritemSpacing
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let marginsAndInsets = Constant.inset * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + Constant.minimumInteritemSpacing * CGFloat(Constant.cellsPerRow - 1)
		let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(Constant.cellsPerRow)).rounded(.down)
		return CGSize(width: itemWidth, height: itemWidth + 30)
	}
}
