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

		collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
		collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
		collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer")
	}
}

extension CollectionViewController: UICollectionViewDelegate {

}

extension CollectionViewController: UICollectionViewDataSource {
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 2
	}
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//		return items.count
		if section == 0 {
			return 4
		} else {
			return 5
		}
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
		cell.backgroundColor = .red
		let label = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
		label.text = items[indexPath.row]
		cell.backgroundView?.addSubview(label)
		return cell
	}
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		if kind == UICollectionView.elementKindSectionHeader {
			let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
			header.backgroundColor = .yellow
			return header
		} else {
			let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath)
			footer.backgroundColor = .orange
			return footer
		}
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		return CGSize(width: self.view.frame.width - 60, height: 50)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
		return CGSize(width: self.view.frame.width - 60, height: 20)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width = (self.view.frame.width - 60) * 0.1
		return CGSize(width: width, height: width)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		let inset = self.view.frame.width * 0.1
		return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return self.view.frame.width * 0.1
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return self.view.frame.width * 0.1
	}
}
