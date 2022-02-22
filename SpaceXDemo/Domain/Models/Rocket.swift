//
//  Rocket.swift
//  SpaceXDemo
//
//  Created by Evgeniy Vaganov on 22.02.2022.
//

import Foundation

struct Rocket: Identifiable {
    let id: String
    let name: String

    init(dto: RocketDTO) {
        id = dto.id
        name = dto.name
    }
}
