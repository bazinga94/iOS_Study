//
//  SampleTableViewController.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/02.
//

import UIKit

class SampleTableViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!

	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.register(UINib(nibName: "InnerTableViewCell", bundle: nil), forCellReuseIdentifier: "InnerTableViewCell")
		tableView.dataSource = self
		tableView.delegate = self
		tableView.rowHeight = UITableView.automaticDimension
	}
}

extension SampleTableViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 3
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "InnerTableViewCell", for: indexPath)
		return cell
	}
}

extension SampleTableViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

		cell.alpha = 0
		cell.layer.transform = CATransform3DTranslate(CATransform3DIdentity, 0, 20, 0)

		DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 * Double(indexPath.row)) {
			cell.alpha = 1
			UIView.animate(withDuration: 0.3) {
				cell.layer.transform = CATransform3DIdentity
			}
		}
		// 이렇게 하면 문제점이 indexPath 에 따라 늦게 반응함...
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 300
	}
}
