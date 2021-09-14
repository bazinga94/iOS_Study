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
		return sectionItems[section].tableCellControllers.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return sectionItems[indexPath.section].tableCellControllers[indexPath.row].cellFromReusableCellHolder(tableView, forIndexPath: indexPath)
	}

	// MARK: - Header
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		return sectionItems[section].sectionFromReusableSectionHolder(tableView, ofKind: "", forIndexPath: IndexPath())	// table view에서 이렇게 쓰니까 어색하네... 고쳐야겠다
	}

	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 60
	}
}

extension ExpandableCollectionViewCell: UITableViewDelegate {

}
