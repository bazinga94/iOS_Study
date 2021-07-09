//
//  CollectionViewController.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/07/09.
//

import UIKit

class CollectionViewController: UIViewController {

	@IBOutlet weak var collectionView: UICollectionView!
	private var items: [String] = ["A", "B", "C", "D", "E"]

	override func viewDidLoad() {
		super.viewDidLoad()

		collectionView.dataSource = self
		collectionView.delegate = self
	}
}

extension CollectionViewController: UICollectionViewDelegate {

}

extension CollectionViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return items.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		<#code#>
	}
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {

}
