//
//  Launch.swift
//  SpaceXDemo
//
//  Created by Evgeniy Vaganov on 21.02.2022.
//
import Foundation

// MARK: - LaunchDataDTO
struct LaunchDataDTO: Decodable {
    let docs: [LaunchDTO]
}

// MARK: - LaunchDTO
struct LaunchDTO: Codable, Identifiable {
    let id: String
    let success: Bool?
    let name: String
    let dateLocal: Date

    enum CodingKeys: String, CodingKey {
        case success, name
        case dateLocal = "date_local"
        case id
    }
}
