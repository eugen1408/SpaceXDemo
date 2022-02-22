//
//  Rocket.swift
//  SpaceXDemo
//
//  Created by Evgeniy Vaganov on 22.02.2022.
//

import Foundation

final class Rocket: Identifiable {
    let id: String
    let height, diameter: LengthDTO
    let mass: MassDTO
    let payloadWeight: PayloadWeightDTO?
    let name: String
    let images: [URL]
    @Published var selectedImage: URL?

    let specs: [SpecsGroup]

    init(dto: RocketDTO) {
        id = dto.id
        name = dto.name
        images = dto.flickrImages.compactMap {
            URL(string: $0)
        }

        var main = SpecsGroup(title: nil, entries: [
            SpecsEntry(text: "Первый запуск", value: dto.firstFlight),
            SpecsEntry(text: "Страна", value: dto.country)
        ])

        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .currency
        if let costPerLaunch = formatter.string(for: dto.costPerLaunch) {
            main.entries.append(SpecsEntry(text: "Стоимость запуска", value: costPerLaunch))
        }

        var firstStage = SpecsGroup(title: "Первая ступень", entries: [
            SpecsEntry(text: "Количество топлива", value: String(dto.firstStage.fuelAmountTons))
        ])
        if let burnTimeSec = dto.firstStage.burnTimeSec {
            firstStage.entries.append(SpecsEntry(text: "Время сгорания", value: String(burnTimeSec)))
        }

        var secondStage = SpecsGroup(title: "Первая ступень", entries: [
            SpecsEntry(text: "Количество топлива", value: String(dto.secondStage.fuelAmountTons))
        ])
        if let burnTimeSec = dto.secondStage.burnTimeSec {
            secondStage.entries.append(SpecsEntry(text: "Время сгорания", value: String(burnTimeSec)))
        }

        specs = [main, firstStage, secondStage]

        height = dto.height
        diameter = dto.diameter
        mass = dto.mass
        payloadWeight = dto.payloadWeights.first(where: { $0.id == "leo" })

        selectRandomImage()
    }

    func selectRandomImage() {
        selectedImage = images.randomElement()
    }

    struct SpecsGroup: Hashable {
        let title: String?
        var entries: [SpecsEntry]
    }

    struct SpecsEntry: Hashable {
        let text, value: String
    }
}
