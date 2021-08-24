//
//  TabBarItem.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/08/24.
//

import UIKit

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
}

struct BankingTab: TabBarItem {
	var type: TabBarType = .banking
	var title: String = TabBarType.banking.rawValue
	var viewController: UIViewController = BankingTabViewController()
	var iconImage: UIImage = UIImage(named: "icon_home")!
}

struct AssetTab: TabBarItem {
	var type: TabBarType = .asset
	var title: String = TabBarType.asset.rawValue
	var viewController: UIViewController = AssetTabViewController()
	var iconImage: UIImage = UIImage(named: "icon_calender")!
}

struct BenefitTab: TabBarItem {
	var type: TabBarType = .benefit
	var title: String = TabBarType.benefit.rawValue
	var viewController: UIViewController = BenefitTabViewController()
	var iconImage: UIImage = UIImage(named: "icon_profile")!
}
