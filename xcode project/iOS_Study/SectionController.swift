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

protocol CollectionViewSectionItem {
	associatedtype CellType: CollectionCellController
	associatedtype SectionType: SectionController<UICollectionView>

	var header: SectionController<SectionType.SectionHolder> { get }
	var rows: [CellController<CellType.ViewType>] { get }
	var footer: SectionController<SectionType.SectionHolder> { get }
}

