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

	var viewModel: InnerTableViewCellViewModel = .init(items: [])
	private var isCellAnimatedList: [IndexPath] = []
	private var initialVisibleLastIndex: Int = 3

	override func awakeFromNib() {
		super.awakeFromNib()
		tableView.register(UINib(nibName: "TodayTableViewCell", bundle: nil), forCellReuseIdentifier: "TodayTableViewCell")
		tableView.dataSource = self
		tableView.delegate = self
		tableView.estimatedRowHeight = 0
		viewModel.cellControllers.bind { [weak self] _ in
			DispatchQueue.main.async {
				self?.isCellAnimatedList = []
				self?.tableView.reloadData()
				self?.initialVisibleLastIndex = self?.tableView.indexPathsForVisibleRows?.last?.row ?? 0
			}
		}
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
		return viewModel.cellControllers.value.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return viewModel.cellControllers.value[indexPath.row].cellFromReusableCellHolder(tableView, forIndexPath: indexPath)
	}
}

extension InnerTableViewCell: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 40
	}

	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		if indexPath.row > initialVisibleLastIndex {
			if isCellAnimatedList.contains(indexPath) == false { //
				cell.alpha = 0.05
				let transform = CATransform3DTranslate(CATransform3DIdentity, 0, 20, 0)
				cell.layer.transform = transform

				let delay = 0.2

				UIView.animate(withDuration: 0.2, delay: delay, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
					cell.alpha = 1
					cell.layer.transform = CATransform3DIdentity
				})

				isCellAnimatedList.append(indexPath)
			}
		} else {
			if isCellAnimatedList.contains(indexPath) == false { //
				cell.alpha = 0.05
				let transform = CATransform3DTranslate(CATransform3DIdentity, 0, 20, 0)
				cell.layer.transform = transform

				let delay = 0.2 * Double(indexPath.row)

				UIView.animate(withDuration: 0.2, delay: delay, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
					cell.alpha = 1
					cell.layer.transform = CATransform3DIdentity
				})

				isCellAnimatedList.append(indexPath)
			}
		}
	}
}
