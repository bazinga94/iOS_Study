//
//  InnerTableViewCell.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/02.
//

import UIKit

class InnerTableViewCell: UITableViewCell {

	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var tableView: UITableView!

//	var viewModel: InnerTableViewCellViewModel = .init(items: [])
	var cellControllers: [TableCellController] = []

	override func awakeFromNib() {
		super.awakeFromNib()
		tableView.register(UINib(nibName: "TodayTableViewCell", bundle: nil), forCellReuseIdentifier: "TodayTableViewCell")
		tableView.dataSource = self
		tableView.delegate = self
		tableView.estimatedRowHeight = 0
//		viewModel.cellControllers.bind { [weak self] _ in
//			DispatchQueue.main.async {
//				self?.tableView.reloadData()
//			}
//		}
		// Initialization code
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)

		// Configure the view for the selected state
	}

	override func prepareForReuse() {
		super.prepareForReuse()
//		self.viewModel.cellControllers.listener = nil	// 필요한가?
	}
}

extension InnerTableViewCell: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//		return viewModel.cellControllers.value.count
		return cellControllers.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//		return viewModel.cellControllers.value[indexPath.row].cellFromReusableCellHolder(tableView, forIndexPath: indexPath)
		return cellControllers[indexPath.row].cellFromReusableCellHolder(tableView, forIndexPath: indexPath)
	}
}

extension InnerTableViewCell: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 40
	}
}
