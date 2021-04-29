//
//  ViewLayoutTestViewController.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/04/29.
//

import UIKit

class ViewLayoutTestViewController: UIViewController {
	let testView = LayoutTestView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))

	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(testView)
		testView.center = CGPoint(x: self.view.frame.size.width  / 2,
								  y: 300)
//		testView.contentMode = .redraw		// content mode 옵션을 redraw로 해주면 frame 변경 시 draw 코드가 자동으로 불린다.
	}

	@IBAction func buttonPressed(sender: UIButton) {
//		testView.setNeedsDisplay()		// setNeedsDisplay 호출 여부에 따라 선이 다르게 보인다. setNeedsDisplay 호출시 draw 코드 호출(즉시 호출은 아님 뷰의 드로잉 사이클에서 호출됨)
		testView.frame.size.width = 250
		testView.frame.size.height = 250
	}
}

class LayoutTestView: UIView {

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = .blue
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	override func draw(_ rect: CGRect) {
		super.draw(rect)

		let color = UIColor.white
		let drect = CGRect(x: 0, y: 0, width: 100, height: 100)
		let bpath = UIBezierPath(rect: drect)

		color.set()
		bpath.stroke()

		print("draw has updated the view")
	}
}
