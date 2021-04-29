//
//  ViewLayoutTestViewController.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/04/29.
//

import UIKit

class ViewLayoutTestViewController: UIViewController {
	let testView = TestView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))

	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(testView)
		//		testView.contentMode = .redraw		// content mode 옵션을 redraw로 해주면 frame 변경 시 draw 코드가 불린다!
	}

	@IBAction func buttonPressed(sender: UIButton) {
		//		testView.setNeedsDisplay()		// setNeedsDisplay 호출 여부에 따라 선이 다르게 보인다. setNeedsDisplay 호출시 draw 코드 호출(즉시 호출은 아님 뷰의 드로잉 사이클에서 호출됨)
		testView.frame = CGRect(x:0, y: 0, width: 300, height: 300)
	}
}

class TestView: UIView {

	override init(frame: CGRect) {
		super.init(frame: frame)
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	override func draw(_ rect: CGRect) {
		super.draw(rect)

		let color = UIColor.red
		let drect = CGRect(x: 0, y: 0, width: 100, height: 100)
		let bpath = UIBezierPath(rect: drect)

		color.set()
		bpath.stroke()

		print("draw has updated the view")
	}
}
