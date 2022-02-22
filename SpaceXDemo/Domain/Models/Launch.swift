//
//  Launch.swift
//  SpaceXDemo
//
//  Created by Evgeniy Vaganov on 22.02.2022.
//

import Foundation

struct Launch: Identifiable {

    let id: String
    let name: String

    init(dto: LaunchDTO) {
        id = dto.id
        name = dto.name
    }
}
