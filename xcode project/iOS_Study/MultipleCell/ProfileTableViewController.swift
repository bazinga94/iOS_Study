//
//  ProfileTableViewController.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/17.
//

import UIKit

class ProfileTableViewController: UITableViewController {

	internal let viewModel = ProfileViewModel()

	override func viewDidLoad() {
		super.viewDidLoad()
		self.tableView.rowHeight = UITableView.automaticDimension
		self.tableView.estimatedRowHeight = 50
	}

	// MARK: - Table view data source

	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.items.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let item = viewModel.items[indexPath.row]

		let cell = tableView.dequeueReusableCell(withIdentifier: type(of: item).reuseId)!
		item.configure(cell: cell)

		return cell
	}
}
