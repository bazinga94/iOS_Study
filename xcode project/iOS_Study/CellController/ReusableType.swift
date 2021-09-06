//
//  ReusableType.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/06.
//

import UIKit

protocol ReusableCell: class {
	associatedtype CellHolder: ReusableCellHolder where CellHolder.CellType == Self
}

extension UITableViewCell: ReusableCell {
	typealias CellHolder = UITableView
}

extension UICollectionViewCell: ReusableCell {
	typealias CellHolder = UICollectionView
}

protocol ReusableCellHolder: class {
	associatedtype CellType: ReusableCell where CellType.CellHolder == Self

	func register(_ nib: UINib?, forCellWithReuseIdentifier identifier: String)
	func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> CellType
}

extension UITableView: ReusableCellHolder {

	func register(_ nib: UINib?, forCellWithReuseIdentifier identifier: String) {
		register(nib, forCellReuseIdentifier: identifier)
	}

	func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
		return dequeueReusableCell(withIdentifier: identifier, for: indexPath)
	}
}

extension UICollectionView: ReusableCellHolder {
}
