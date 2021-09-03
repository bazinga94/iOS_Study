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
//		tableView.register(UINib(nibName: "TodayTableViewCell", bundle: nil), forCellReuseIdentifier: "TodayTableViewCell")
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
//		let cell = tableView.dequeueReusableCell(withIdentifier: "TodayTableViewCell", for: indexPath) as! TodayTableViewCell
//		cell.titleLabel.text = "\(String(indexPath.row))"
		return cell
	}
}

extension SampleTableViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

		cell.alpha = 0
		cell.layer.transform = CATransform3DTranslate(CATransform3DIdentity, 0, 20, 0)

//		UIView.animate(withDuration: 0.3, delay: 0.3 * Double(indexPath.row), options: .curveLinear) {
//			cell.layer.transform = CATransform3DIdentity
//			cell.alpha = 1
//		}

		DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 * Double(indexPath.row)) {
			cell.alpha = 1
			UIView.animate(withDuration: 0.3) {
				cell.layer.transform = CATransform3DIdentity
			}
		}
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 300
	}
}
