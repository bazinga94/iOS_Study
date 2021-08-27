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

	override func viewDidLoad() {
		super.viewDidLoad()
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
