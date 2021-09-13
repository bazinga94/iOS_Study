//
//  BaseCollectionViewController.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/13.
//

import UIKit

class BaseCollectionViewController: UIViewController {

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
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return sectionItems.count
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

}

private extension BaseCollectionViewController {
	func configureCollectionView() {
		collectionView.delegate = self
		collectionView.dataSource = self
		factory.registerCells(on: collectionView)
	}

	func bindCollectionView() {
		viewModel.baseCollectionModel.bind { [weak self] model in
			guard let self = self else { return }
			self.sectionItems = self.factory.makeCellControllers(by: model)
		}
	}
}
