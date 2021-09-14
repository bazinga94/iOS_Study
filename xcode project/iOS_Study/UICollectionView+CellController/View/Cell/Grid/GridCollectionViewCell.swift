//
//  GridCollectionViewCell.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/13.
//

import UIKit

class GridCollectionViewCell: UICollectionViewCell {

	enum Constant {
		static let inset: CGFloat = 0
		static let minimumLineSpacing: CGFloat = 10
		static let minimumInteritemSpacing: CGFloat = 5
	}

	@IBOutlet weak var collectionView: UICollectionView!
	var cellControllers: [CellController<UICollectionView>] = []

	override func awakeFromNib() {
		super.awakeFromNib()
		configureCollectionView()
	}
}

private extension GridCollectionViewCell {
	func configureCollectionView() {
		GridContentsCollectionViewCellController.registerCell(on: collectionView)
		collectionView.delegate = self
		collectionView.dataSource = self
	}
}

extension GridCollectionViewCell: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return cellControllers.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		return cellControllers[indexPath.row].cellFromReusableCellHolder(collectionView, forIndexPath: indexPath)
	}
}

extension GridCollectionViewCell: UICollectionViewDelegateFlowLayout {
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
		//		let marginsAndInsets = Constant.inset * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + Constant.minimumInteritemSpacing * CGFloat(Constant.cellsPerRow - 1)
		//		let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(Constant.cellsPerRow)).rounded(.down)
		//		return CGSize(width: itemWidth, height: itemWidth + 30)

		let width = collectionView.frame.width * 0.9
		let estimatedHeight: CGFloat = 100.0
		let dummyCell = cellControllers[indexPath.row].cellFromReusableCellHolder(collectionView, forIndexPath: indexPath)
		dummyCell.layoutIfNeeded()
		let estimatedSize = dummyCell.systemLayoutSizeFitting(
			CGSize(width: width, height: estimatedHeight))
		return CGSize(width: width, height: estimatedSize.height)
	}
}
