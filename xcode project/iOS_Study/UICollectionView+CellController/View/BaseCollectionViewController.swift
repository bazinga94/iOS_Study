//
//  BaseCollectionViewController.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/13.
//

import UIKit

class BaseCollectionViewController: UIViewController {

	enum Constant {
		static let inset: CGFloat = 0
		static let minimumLineSpacing: CGFloat = 20
		static let minimumInteritemSpacing: CGFloat = 10
		static let cellsPerRow = 1
	}

	@IBOutlet weak var collectionView: UICollectionView!

	private var factory = BaseCollectionViewCellFactory()
	private var sectionItems: [SectionController<UICollectionView>] = []
	var viewModel: BaseCollectionViewModel = BaseCollectionViewModel()

	override func viewDidLoad() {
		super.viewDidLoad()
		configureCollectionView()
		bindCollectionView()
	}
}

extension BaseCollectionViewController: UICollectionViewDataSource {
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return sectionItems.count
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return sectionItems[section].collectionCellControllers.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		return sectionItems[indexPath.section].collectionCellControllers[indexPath.row].cellFromReusableCellHolder(collectionView, forIndexPath: indexPath)
	}
}

extension BaseCollectionViewController: UICollectionViewDelegate {
	// MARK: - Header
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

		return sectionItems[indexPath.section].sectionFromReusableSectionHolder(collectionView, ofKind: UICollectionView.elementKindSectionHeader, forIndexPath: indexPath)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		return CGSize(width: collectionView.frame.width, height: 40)
	}
}

extension BaseCollectionViewController: UICollectionViewDelegateFlowLayout {
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

		let width = view.frame.width
		let estimatedHeight: CGFloat = 300.0
		let dummyCell = sectionItems[indexPath.section].collectionCellControllers[indexPath.row].cellFromReusableCellHolder(collectionView, forIndexPath: indexPath)
		dummyCell.layoutIfNeeded()
		let estimatedSize = dummyCell.systemLayoutSizeFitting(CGSize(width: width, height: estimatedHeight))
		return CGSize(width: width, height: estimatedSize.height)
	}
}

private extension BaseCollectionViewController {
	func configureCollectionView() {
		collectionView.delegate = self
		collectionView.dataSource = self
		factory.registerCells(on: collectionView)
	}

	func bindCollectionView() {
		viewModel.fetch()
		viewModel.baseCollectionModel.bind { [weak self] model in
			guard let self = self else { return }
			self.sectionItems = self.factory.makeCellControllers(by: model)
			self.collectionView.reloadData()
		}
	}
}
