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

	override func awakeFromNib() {
		super.awakeFromNib()
		tableView.register(UINib(nibName: "TodayTableViewCell", bundle: nil), forCellReuseIdentifier: "TodayTableViewCell")
		tableView.dataSource = self
		// Initialization code
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)

		// Configure the view for the selected state
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		tableView.reloadData()
		tableView.invalidateIntrinsicContentSize()
		tableView.contentSize = tableView.intrinsicContentSize
	}
}

extension InnerTableViewCell: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 3
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "TodayTableViewCell", for: indexPath) as! TodayTableViewCell
		cell.titleLabel.text = "\(String(indexPath.row))"
		return cell
	}
}
