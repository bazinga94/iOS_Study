//
//  FirstSectionTableViewCell.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/02.
//

import UIKit

class FirstSectionTableViewCell: UITableViewCell {

	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var tableView: FittedTableView!
//	@IBOutlet weak var tableViewHeight: NSLayoutConstraint!

	private let factory = FirstSectionTableViewCellFactory()
	var cellControllers: [TableCellController] = []

	override func awakeFromNib() {
		super.awakeFromNib()
//		tableView.register(UINib(nibName: "TodayTableViewCell", bundle: nil), forCellReuseIdentifier: "TodayTableViewCell")
		factory.registerCells(on: tableView)
		tableView.dataSource = self
		tableView.delegate = self
		tableView.estimatedRowHeight = 40
		tableView.rowHeight = UITableView.automaticDimension
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}

	override func prepareForReuse() {
		super.prepareForReuse()
	}

	override func layoutSubviews() {
		super.layoutSubviews()
//		tableView.reloadData()
//		tableView.invalidateIntrinsicContentSize()
//		tableViewHeight.constant = tableView.contentSize.height
//		self.layoutIfNeeded()
	}
}

extension FirstSectionTableViewCell: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return cellControllers.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return cellControllers[indexPath.row].cellFromReusableCellHolder(tableView, forIndexPath: indexPath)
	}
}

extension FirstSectionTableViewCell: UITableViewDelegate {
//	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
////		return UITableView.automaticDimension
//		return 40
//	}
}
