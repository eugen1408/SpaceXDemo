//
//  RocketDataDTO.swift
//  SpaceXDemo
//
//  Created by Evgeniy Vaganov on 21.02.2022.
//

import Foundation

// MARK: - RocketDataDTO
struct RocketDataDTO: Decodable {
    let docs: [RocketDTO]
}

// MARK: - RocketDTO
struct RocketDTO: Decodable {
    let height, diameter: DiameterDTO
    let mass: MassDTO
    let firstStage, secondStage: StageDTO
    let payloadWeights: [PayloadWeightDTO]
    let flickrImages: [String]
    let name: String
    let costPerLaunch: Decimal
    let firstFlight, country, id: String

    enum CodingKeys: String, CodingKey {
        case height, diameter, mass
        case firstStage = "first_stage"
        case secondStage = "second_stage"
        case payloadWeights = "payload_weights"
        case flickrImages = "flickr_images"
        case name
        case costPerLaunch = "cost_per_launch"
        case firstFlight = "first_flight"
        case country, id
    }
}

// MARK: - DiameterDTO
struct DiameterDTO: Decodable {
    let meters, feet: Double
}

// MARK: - StageDTO
struct StageDTO: Decodable {
    let fuelAmountTons: Double
    let burnTimeSec: Double?

    enum CodingKeys: String, CodingKey {
        case fuelAmountTons = "fuel_amount_tons"
        case burnTimeSec = "burn_time_sec"
    }
}

// MARK: - MassDTO
struct MassDTO: Decodable {
    let kg, lb: Double
}

// MARK: - PayloadWeightDTO
struct PayloadWeightDTO: Decodable {
    let id, name: String
    let kg, lb: Double
}
