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
	private var viewItems: CollectionViewItem?
	var viewModel: BaseCollectionViewModel = BaseCollectionViewModel()

	override func viewDidLoad() {
		super.viewDidLoad()
		configureCollectionView()
		bindCollectionView()
	}
}

extension BaseCollectionViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewItems?.items[section]
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		return viewItems[indexPath.section].items[indexPath.row]
	}
}

extension BaseCollectionViewController: UICollectionViewDelegate {

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
			?? = self?.factory.makeCellControllers(by: model)
		}
	}
}
