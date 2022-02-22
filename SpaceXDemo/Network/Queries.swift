//
//  Queries.swift
//  SpaceXDemo
//
//  Created by Evgeniy Vaganov on 22.02.2022.
//

import Foundation

// TODO: сериализовать из объектов

enum Queries {
    static let rockets = """
    {
    "query": {  },
    "options": {
    "pagination": false,
    "select": "id name height diameter mass first_stage second_stage flickr_images first_flight cost_per_launch country payload_weights",
    "sort": "-first_flight"
    }
    }
    """.data(using: .utf8)

    static func launch(rocketId: String) -> Data? {
        """
        {
        "query": { "rocket": "\(rocketId)" },
        "options": {
        "pagination": false,
        "select": "name date_local success",
        "sort": "-date_local"
        }
        }
        """.data(using: .utf8)
    }
}
