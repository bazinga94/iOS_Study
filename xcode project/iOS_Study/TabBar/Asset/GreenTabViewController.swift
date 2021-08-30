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
//	private let cellWidth: CGFloat = 200
	private let cellSpacing: CGFloat = 10		// cell 간격
	private let horizontalInset: CGFloat = 30	// 컬렉션뷰 좌우 간격
	private var isOneStepPaging = true
	private var currentIndex: CGFloat = 0

	var layout: CenterHorizontalLayout?

	override func viewDidLoad() {
		super.viewDidLoad()
		collectionView.dataSource = self
//		collectionView.delegate = self
//
//		let layout = UICollectionViewFlowLayout()
//		layout.scrollDirection = .horizontal
//		collectionView.collectionViewLayout = layout
		layout = CenterHorizontalLayout(cellSpacing: cellSpacing, horizontalInset: horizontalInset, isOneStepPaging: true)
		collectionView.collectionViewLayout = layout ?? UICollectionViewFlowLayout()
		collectionView.delegate = layout
		collectionView.decelerationRate = .fast
		collectionView.showsHorizontalScrollIndicator = false

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

//extension GreenTabViewController: UICollectionViewDelegate {
//	func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
//	{
//
//		// item의 사이즈와 item 간의 간격 사이즈를 구해서 하나의 item 크기로 설정.
////		let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//		let cellWidth = collectionView.bounds.width - horizontalInset * 2.0
//		let cellWidthIncludingSpacing = cellWidth + cellSpacing
//
//		// targetContentOff을 이용하여 x좌표가 얼마나 이동했는지 확인
//		// 이동한 x좌표 값과 item의 크기를 비교하여 몇 페이징이 될 것인지 값 설정
//		var offset = targetContentOffset.pointee
//		let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
//		var roundedIndex = round(index)
//
//		// scrollView, targetContentOffset의 좌표 값으로 스크롤 방향을 알 수 있다.
//		// index를 반올림하여 사용하면 item의 절반 사이즈만큼 스크롤을 해야 페이징이 된다.
//		// 스크로로 방향을 체크하여 올림,내림을 사용하면 좀 더 자연스러운 페이징 효과를 낼 수 있다.
//		if scrollView.contentOffset.x > targetContentOffset.pointee.x {
//			roundedIndex = floor(index)
//		} else if scrollView.contentOffset.x < targetContentOffset.pointee.x {
//			roundedIndex = ceil(index)
//		} else {
//			roundedIndex = round(index)
//		}
//
//		if isOneStepPaging {
//			if currentIndex > roundedIndex {
//				currentIndex -= 1
//				roundedIndex = currentIndex
//			} else if currentIndex < roundedIndex {
//				currentIndex += 1
//				roundedIndex = currentIndex
//			}
//		}
//
//		// 위 코드를 통해 페이징 될 좌표값을 targetContentOffset에 대입하면 된다.
//		offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
//		targetContentOffset.pointee = offset
//	}
//}
//
//extension GreenTabViewController: UICollectionViewDelegateFlowLayout {
//	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//		return .init(width: collectionView.bounds.width - horizontalInset * 2.0, height: collectionView.bounds.height)
//	}
//
//	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//		return cellSpacing
//	}
//
//	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//		let insetX: CGFloat = horizontalInset
//		let insetY: CGFloat = 0
//		return .init(top: insetY, left: insetX, bottom: insetY, right: insetX)
//	}
//}

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
