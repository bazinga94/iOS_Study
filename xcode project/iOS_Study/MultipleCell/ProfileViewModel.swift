//
//  ProfileViewModel.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/09/17.
//

import Foundation

typealias ProfileCellConfigurator = CollectionCellConfigurator<ProfileCell, Profile>

class ProfileViewModel {
	let items: [CellConfigurator] = [
		ProfileCellConfigurator(item: Profile(name: "쫑호"))
	]
}
