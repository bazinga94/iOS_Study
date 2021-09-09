//
//  SampleTableViewController.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/02.
//

import UIKit

class SampleTableViewController: UIViewController {

	private var viewModel: SampleTableViewModel = .init()
	private var isCellAnimatedList: [IndexPath] = []
	private var initialVisibleLastIndex: Int = 0	// 또 다른 방법!, 처음 보여질 셀에 대해 미리 알려주는것... 근데 이건 화면 크기 마다 다를텐데ㅠ.. 안되겠다
	private var animationStart: Bool = false
	private var factory = SampleTableViewFactory()
	private var cellControllers: [[TableCellController]] = [[]]
	private lazy var tableView: UITableView = UITableView()
		.builder
		.apply {
//			$0.register(UINib(nibName: "InnerTableViewCell", bundle: nil), forCellReuseIdentifier: "InnerTableViewCell")
			$0.dataSource = self
			$0.delegate = self
			$0.estimatedRowHeight = 0 //UITableView.automaticDimension			// estimatedRowHeight를 지정하지 않으면 willDisplay가 한번에 호출된다. -> 아마 기준 높이가 없어서 그런듯?! + estimatedRowHeight에 따라 보여줄 indexPath가 정해짐
			// 0으로 지정하니 제대로된 값을 가져온다
			$0.rowHeight = UITableView.automaticDimension
		}
		.build()

	override func viewDidLoad() {
		super.viewDidLoad()
		addTableView()
		bind()
		fetch()
	}
}

private extension SampleTableViewController {
	func addTableView() {
		self.view.addSubview(tableView)
		tableView.fitSuperView()
		factory.registerCells(on: tableView)
	}

	func bind() {
		viewModel.sampleTableModel.bind { [weak self] model in
			guard let self = self else { return }
			DispatchQueue.main.async {
				self.isCellAnimatedList = []
				self.cellControllers = self.factory.cellControllers(items: model)
				self.tableView.reloadData()
				self.initialVisibleLastIndex = self.tableView.indexPathsForVisibleRows?.last?.row ?? 0
			}
		}
	}

	func fetch() {
		viewModel.fetchDummyData()
	}
}

extension SampleTableViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return cellControllers.count
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return cellControllers[section].count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return cellControllers[indexPath.section][indexPath.row].cellFromReusableCellHolder(tableView, forIndexPath: indexPath)
	}
}

extension SampleTableViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

		if indexPath.row > initialVisibleLastIndex {
			if isCellAnimatedList.contains(indexPath) == false { //
				cell.alpha = 0.05
				let transform = CATransform3DTranslate(CATransform3DIdentity, 0, 20, 0)
				cell.layer.transform = transform

				let delay = 0.2

				UIView.animate(withDuration: 0.2, delay: delay, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut, .allowUserInteraction], animations: {
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

				UIView.animate(withDuration: 0.2, delay: delay, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut, .allowUserInteraction], animations: {
					cell.alpha = 1
					cell.layer.transform = CATransform3DIdentity
				})

				isCellAnimatedList.append(indexPath)
			}
		}
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 150
	}
}
