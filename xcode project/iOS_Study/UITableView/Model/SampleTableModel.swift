//
//  SampleTableModel.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/06.
//

import Foundation

struct SampleTableModel {
	var firstModel: [FirstDummyModel]
	var secondModel: [SecondDummyModel]
	var menuModel: [String]
}

struct FirstDummyModel {
	var title: String
	var content: [String]
}

struct SecondDummyModel {
	var content: [String]
}
