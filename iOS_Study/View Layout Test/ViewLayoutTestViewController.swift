//
//  ViewLayoutTestViewController.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/04/29.
//

import UIKit

class ViewLayoutTestViewController: UIViewController {
	let testView = LayoutTestView(frame: CGRect(x: 0, y: 100, width: 200, height: 200))
	let shapeView = ShapeView(frame: CGRect(x: 0, y: 500, width: 200, height: 200))

	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(testView)
		view.addSubview(shapeView)
//		testView.center = CGPoint(x: self.view.frame.size.width/2, y: 300)
//		testView.contentMode = .redraw		// content mode 옵션을 redraw로 해주면 frame 변경 시 draw 코드가 자동으로 불린다.
	}

	@IBAction func buttonPressed(sender: UIButton) {
		testView.setNeedsDisplay()		// setNeedsDisplay 호출 여부에 따라 선이 다르게 보인다. setNeedsDisplay 호출시 draw 코드 호출(즉시 호출은 아님 뷰의 드로잉 사이클에서 호출됨)
		testView.frame.size.width = self.view.frame.size.width
		testView.frame.size.height = self.view.frame.size.width

//		shapeView.setNeedsLayout()
		shapeView.frame.size.width = self.view.frame.size.width/2
		shapeView.frame.size.height = self.view.frame.size.width/2
	}
}

class ShapeView: UIView {

	/// 처음 view의 크기가 변경 된 경우에만 호출됨
	override func layoutSubviews() {
		self.backgroundColor = .random()
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

extension UIColor {
	static func random() -> UIColor {
		return UIColor(
			red:   .random(in: 0...1),
			green: .random(in: 0...1),
			blue:  .random(in: 0...1),
			alpha: 1.0
		)
	}
}
