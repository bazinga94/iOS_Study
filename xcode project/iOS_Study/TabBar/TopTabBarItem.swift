//
//  TopTabBarItem.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/08/26.
//

import UIKit

//enum TopTabBarType {
//	case view
//	case viewController
//}

protocol TopTabBarItem {
//	var type: TopTabBarType { get }
	var title: String { get }
	var viewController: UIViewController { get }
}

struct FirstTopTab: TopTabBarItem {
	var title: String = "빨간 탭"
	var viewController: UIViewController = {
		let viewController = UIViewController()
		viewController.view.backgroundColor = .red
		return viewController
	}()
}

struct SecondTopTab: TopTabBarItem {
	var title: String = "초록 탭"
	var viewController: UIViewController = {
		let viewController = UIViewController()
		viewController.view.backgroundColor = .green
		return viewController
	}()
}
