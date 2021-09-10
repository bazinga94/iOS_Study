//
//  CellController.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/08/27.
//

import UIKit

typealias TableCellController = CellController<UITableView>
typealias CollectionCellController = CellController<UICollectionView>

protocol CellControllerType {
	associatedtype ViewType: ReusableCellHolder

	static func registerCell(on reusableCellHolder: ViewType)
	func cellFromReusableCellHolder(_ reusableCellHolder: ViewType, forIndexPath indexPath: IndexPath) -> ViewType.CellType
	func didSelectCell(itemAt indexPath: IndexPath)
}

class CellController<T: ReusableCellHolder>: CellControllerType {

	class var cellClass: AnyClass {		// override 가능
		fatalError("Must be implemented by children")
	}

	static var cellIdentifier: String {
		return String(describing: cellClass)
	}

	static func registerCell(on reusableCellHolder: T) {
		let bundle = Bundle(for: cellClass)
		let nib = UINib(nibName: cellIdentifier, bundle: bundle)
		reusableCellHolder.register(nib, forCellWithReuseIdentifier: cellIdentifier)
	}

	func cellFromReusableCellHolder(_ reusableCellHolder: T, forIndexPath indexPath: IndexPath) -> T.CellType {
		let cell = reusableCellHolder.dequeueReusableCell(withReuseIdentifier: type(of: self).cellIdentifier, for: indexPath)
//		if let cellTemp = cell as? SecondSectionTableViewCell {
//			cellTemp.delegate = 
//		}
		configureCell(cell)
		return cell
	}

	func configureCell(_ cell: T.CellType) {
		// 자식 클래스에서 override하여 구현
	}

	func didSelectCell(itemAt indexPath: IndexPath) {
		// 자식 클래스에서 override하여 구현
	}
}

class GenericCellController<T: ReusableCell>: CellController<T.CellHolder> {

	final override class var cellClass: AnyClass {
		return T.self
	}

	override func configureCell(_ cell: T) {
		// Generic 타입을 인자로 받아 override 하여 구현
	}
}
