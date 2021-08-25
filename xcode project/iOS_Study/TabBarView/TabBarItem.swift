//
//  TabBarItem.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/08/24.
//

import UIKit
import Lottie

enum TabBarType: String {
	case banking = "뱅킹"
	case asset = "자산"
	case benefit = "혜택"
	case productMall = "상품몰"
	case menu = "전체메뉴"
}

protocol TabBarItem {
	var type: TabBarType { get }
	var title: String { get }
	var viewController: UIViewController { get }
	var iconImage: UIImage { get }
	var lottieView: AnimationView { get }
}

struct BankingTab: TabBarItem {
	var type: TabBarType = .banking
	var title: String = TabBarType.banking.rawValue
	var viewController: UIViewController = BankingTabViewController()
	var iconImage: UIImage = UIImage(named: "icon_home")!
	var lottieView: AnimationView = AnimationView(name: "lottie-1")
}

struct AssetTab: TabBarItem {
	var type: TabBarType = .asset
	var title: String = TabBarType.asset.rawValue
	var viewController: UIViewController = AssetTabViewController()
	var iconImage: UIImage = UIImage(named: "icon_calender")!
	var lottieView: AnimationView = AnimationView(name: "lottie-2")
}

struct BenefitTab: TabBarItem {
	var type: TabBarType = .benefit
	var title: String = TabBarType.benefit.rawValue
	var viewController: UIViewController = BenefitTabViewController()
	var iconImage: UIImage = UIImage(named: "icon_profile")!
	var lottieView: AnimationView = AnimationView(name: "lottie-3")
}
