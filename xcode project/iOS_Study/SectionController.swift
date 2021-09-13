//
//  SectionController.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/13.
//

import UIKit
// CollectionView에 대해서만 구현

protocol SectionViewType: class {
	associatedtype SectionHolder: SectionViewHolder where SectionHolder.Section == Self
}

protocol SectionViewHolder: class {
	associatedtype Section: SectionViewType where Section.SectionHolder == Self

	func register(_ viewClass: AnyClass?, forSupplementaryViewOfKind elementKind: String, withReuseIdentifier identifier: String)
	func dequeueReusableSupplementaryView(ofKind elementKind: String, withReuseIdentifier identifier: String, for indexPath: IndexPath) -> Section
}

extension UICollectionReusableView: SectionViewType {
	typealias SectionHolder = UICollectionView
}

extension UICollectionView: SectionViewHolder {
	typealias Section = UICollectionReusableView
}

extension UITableViewHeaderFooterView: SectionViewType {
	typealias SectionHolder = UITableView
}

extension UITableView: SectionViewHolder {
	typealias Section = UITableViewHeaderFooterView

	func register(_ viewClass: AnyClass?, forSupplementaryViewOfKind elementKind: String, withReuseIdentifier identifier: String) {
		register(viewClass, forHeaderFooterViewReuseIdentifier: identifier)
	}

	func dequeueReusableSupplementaryView(ofKind elementKind: String, withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewHeaderFooterView {
		guard let view = dequeueReusableHeaderFooterView(withIdentifier: identifier) else {
			return UITableViewHeaderFooterView(reuseIdentifier: identifier)
		}
		return view
	}
}

//extension UIView: SectionViewType {
//	typealias SectionHolder = UITableView
//}

//protocol CollectionReusableView: class {
//	associatedtype SectionHolder: SectionViewHolder
//}

protocol SectionControllerType {
	associatedtype SectionHolder: SectionViewHolder

	static func registerSection(on sectionViewHolder: SectionHolder)
	func sectionFromReusableSectionHolder(_ reusableSectionHolder: SectionHolder, ofKind: String, forIndexPath indexPath: IndexPath)
}

class SectionController<T: SectionViewHolder>: SectionControllerType {
	class var cellClass: AnyClass {
		fatalError("Must be implemented by children")
	}

	static var sectionIdentifier: String {
		return String(describing: cellClass)
	}

	static func registerSection(on sectionViewHolder: T) {
		sectionViewHolder.register(cellClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionIdentifier)
	}

	func sectionFromReusableSectionHolder(_ reusableSectionHolder: T, ofKind: String, forIndexPath indexPath: IndexPath) {
		let section = reusableSectionHolder.dequeueReusableSupplementaryView(ofKind: ofKind, withReuseIdentifier: type(of: self).sectionIdentifier, for: indexPath)
		configureSection(section)
	}

	func configureSection(_ section: T.Section) {
	}
}

class GenericSectionController<T: SectionViewType>: SectionController<T.SectionHolder> {
	final override class var cellClass: AnyClass {
		return T.self
	}

	override func configureSection(_ section: T) {
	}
}

//protocol SectionItem {
//	associatedtype CellType: CollectionCellController
//	associatedtype SectionType: SectionController<UICollectionView>
//
//	var header: SectionController<SectionType.SectionHolder> { get }
//	var rows: [CellController<CellType.ViewType>] { get }
//	var footer: SectionController<SectionType.SectionHolder> { get }
//}
//
//struct CollectionViewSectionItems<T: SectionViewHolder>: SectionItem {
//	var header: SectionController<T>?
//	var rows: [CellController<T>]
//	var footer: SectionController<T>?
//}

protocol SectionItem {
	var collectionHeader: SectionController<UICollectionView>? { get }
	var tableHeader: SectionController<UITableView>? { get }
	var collectionRows: [CellController<UICollectionView>] { get }
	var tableRows: [CellController<UITableView>] { get }
	var collectionFooter: SectionController<UICollectionView>? { get }
	var tableFooter: SectionController<UITableView>? { get }
}

protocol CollectionViewItem {
	var header: SectionController<UICollectionView>? { get }
	var items: [SectionItem] { get }
	var footer: SectionController<UICollectionView>? { get }
}
