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
	var viewModel: BaseCollectionViewModel = BaseCollectionViewModel()

	override func viewDidLoad() {
		super.viewDidLoad()
		configureCollectionView()
		bindCollectionView()
	}
}

extension BaseCollectionViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		<#code#>
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		<#code#>
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
		viewModel.baseCollectionModel.bind { model in
			factory.makeCellControllers(by: <#T##<<error type>>#>)
		}
	}
}
