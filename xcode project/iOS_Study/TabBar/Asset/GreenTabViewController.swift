//
//  GreenTabViewController.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/08/26.
//

import UIKit

struct GreenTabModel {
	let title: String
}

class GreenTabViewController: UIViewController {

	@IBOutlet weak var collectionView: UICollectionView!
	private let model: [GreenTabModel] = [
		GreenTabModel(title: "1"),
		GreenTabModel(title: "2"),
		GreenTabModel(title: "3"),
		GreenTabModel(title: "4"),
		GreenTabModel(title: "5"),
		GreenTabModel(title: "6"),
		GreenTabModel(title: "7"),
		GreenTabModel(title: "8"),
		GreenTabModel(title: "9")
	]
	private let factory: GreenTabCellFactory = GreenTabCellFactory()
//	private var cellControllers: [CellController<UICollectionView>] = []
	private var cellControllers: [GenericCellController<GreenTabCollectionViewCell>] = []
	private let cellWidth: CGFloat = 200
	private let cellSpacing: CGFloat = 10		// cell 간격
	private let horizontalInset: CGFloat = 30	// 컬렉션뷰 좌우 간격

	override func viewDidLoad() {
		super.viewDidLoad()
		collectionView.dataSource = self
		collectionView.delegate = self

		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		collectionView.collectionViewLayout = layout

		factory.registerCells(on: collectionView)
		cellControllers = factory.cellController(with: model)
	}
}

extension GreenTabViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return cellControllers.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		return cellControllers[indexPath.row].cellFromReusableCellHolder(collectionView, forIndexPath: indexPath)
	}
}

extension GreenTabViewController: UICollectionViewDelegate {
}

extension GreenTabViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return .init(width: collectionView.bounds.width - horizontalInset * 2.0, height: collectionView.bounds.height)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return cellSpacing
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		let insetX: CGFloat = horizontalInset
		let insetY: CGFloat = 0
		return .init(top: insetY, left: insetX, bottom: insetY, right: insetX)
	}
}

class GreenTabCellFactory {
	func registerCells(on collectionView: UICollectionView) {
		GreenTabCellController.registerCell(on: collectionView)
	}

	func cellController(with items: [GreenTabModel]) -> [GenericCellController<GreenTabCollectionViewCell>] {
		return items.map {
			GreenTabCellController(item: $0)
		}
	}
}

class GreenTabCellController: GenericCellController<GreenTabCollectionViewCell> {
	var item: GreenTabModel

	init(item: GreenTabModel) {
		self.item = item
	}

	override func configureCell(_ cell: GreenTabCollectionViewCell) {
		cell.titleLabel.text = item.title
	}
}
