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
    let date: String
    let success: Bool?

    init(dto: LaunchDTO) {
        id = dto.id
        name = dto.name
        date = dto.dateLocal.formatted(date: .long, time: .omitted)
        success = dto.success
    }
}
