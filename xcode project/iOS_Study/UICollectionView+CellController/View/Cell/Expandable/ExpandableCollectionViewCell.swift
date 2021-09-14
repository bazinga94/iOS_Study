//
//  ExpandableCollectionViewCell.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/13.
//

import UIKit

class ExpandableCollectionViewCell: UICollectionViewCell {

	@IBOutlet weak var tableView: UITableView!
	var sectionItems: [SectionController<UITableView>] = []
	weak var delegate: SectionReloadDelegate?

	var isExpanded = true

	override func awakeFromNib() {
		super.awakeFromNib()
		configureTableView()
	}
}

private extension ExpandableCollectionViewCell {
	func configureTableView() {
		ExpandableTableViewSectionController.registerSection(on: tableView)
		ExpandableTableViewCellController.registerCell(on: tableView)
		tableView.delegate = self
		tableView.dataSource = self
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 40
	}
}

extension ExpandableCollectionViewCell: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return sectionItems.count
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 0, !isExpanded {
			return 0
		}
		return sectionItems[section].tableCellControllers.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return sectionItems[indexPath.section].tableCellControllers[indexPath.row].cellFromReusableCellHolder(tableView, forIndexPath: indexPath)
	}

	// MARK: - Header
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let sectionView = sectionItems[section].sectionFromReusableSectionHolder(tableView, ofKind: "", forIndexPath: IndexPath())	// table view에서 이렇게 쓰니까 어색하네... 고쳐야겠다
		if let sectionView = sectionView as? ExpandableTableViewHeaderSection {
			sectionView.sectionButton.addTarget(self, action: #selector(hideSection(button:)), for: .touchUpInside)
		}
		return sectionView
	}

	@objc func hideSection(button: UIButton) {
		let section = 0 // 내 계좌 목록 section
		var indexPaths = [IndexPath]()

		for row in 0..<sectionItems[section].tableCellControllers.count {
			let indexPath = IndexPath(row: row, section: section)
			indexPaths.append(indexPath)
		}
//		var isExpanded = true

		tableView.performBatchUpdates({
			if isExpanded {
				tableView.deleteRows(at: indexPaths, with: .fade)
			} else {
				tableView.insertRows(at: indexPaths, with: .fade)
			}
			isExpanded = !isExpanded
			self.delegate?.reload(section: 0)
		}, completion: { _ in
//			self.delegate?.reload(section: 0)
		})
	}

	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 60
	}
}

extension ExpandableCollectionViewCell: UITableViewDelegate {

}
