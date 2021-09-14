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
		static let minimumInteritemSpacing: CGFloat = 20
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
//		let flowLayout = UICollectionViewFlowLayout()
//		flowLayout.scrollDirection = .horizontal
//		flowLayout.estimatedItemSize = CGSize(width: 80, height: 80)
//		collectionView.setCollectionViewLayout(flowLayout, animated: false)
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

//		let width: CGFloat = 30 //collectionView.frame.width
//		let estimatedHeight: CGFloat = 80.0
//		let dummyCell = cellControllers[indexPath.row].cellFromReusableCellHolder(collectionView, forIndexPath: indexPath)
//		dummyCell.layoutIfNeeded()
//		let estimatedSize = dummyCell.systemLayoutSizeFitting(CGSize(width: width, height: estimatedHeight))
//		return estimatedSize
//		return CGSize(width: estimatedSize.width, height: estimatedSize.height)
		let width = cellControllers[indexPath.row].cellWidth(availableHeight: 40, collectionView, itemAt: indexPath)
		return CGSize(width: width, height: 40)
	}
}
