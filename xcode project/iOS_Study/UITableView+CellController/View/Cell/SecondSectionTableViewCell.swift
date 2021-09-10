//
//  SecondSectionTableViewCell.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/09.
//

import UIKit

class SecondSectionTableViewCell: UITableViewCell {

	weak var delegate: SecondSectionTableViewCellDelegate?

	enum Constant {
		static let inset: CGFloat = 20
		static let minimumLineSpacing: CGFloat = 20
		static let minimumInteritemSpacing: CGFloat = 10
		static let cellsPerRow = 5
	}

	@IBOutlet weak var collectionView: FittedCollectionView!

	@IBAction func footerButtonAction(_ sender: Any) {
		let indexPaths = [0, 1, 2, 3, 4].map { IndexPath(row: $0, section: 0) }

		collectionView.performBatchUpdates({
			if isExpanded {
				viewModel?.deleteMenuData()
				collectionView.deleteItems(at: indexPaths)
				isExpanded = false
				self.delegate?.reload()
			} else {
				viewModel?.fetchAllMenuData()
				collectionView.insertItems(at: indexPaths)
				isExpanded = true
				self.delegate?.reload()
			}
		}, completion: nil)
	}

	var viewModel: SecondSectionTableViewModel?
	var factory = SecondSectionTableViewCellFactory()
	var cellControllers: [CollectionCellController] = []
	var isExpanded: Bool = true

	override func awakeFromNib() {
		super.awakeFromNib()
		factory.registerCells(on: collectionView)
		collectionView.dataSource = self
		collectionView.delegate = self
//		viewModel?.sampleCollectionModel.bind(listener: { [weak self] menuList in
//			guard let self = self else { return }
//			self.cellControllers = self.factory.cellControllers(items: menuList)
//		})
		// Initialization code
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		viewModel?.fetchAllMenuData()
		collectionView.reloadData()
		viewModel?.sampleCollectionModel.bind(listener: { [weak self] menuList in
			guard let self = self else { return }
			self.cellControllers = self.factory.cellControllers(items: menuList)
		})
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
