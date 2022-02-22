//
//  MainViewModel.swift
//  SpaceXDemo
//
//  Created by Evgeniy Vaganov on 22.02.2022.
//

import Foundation
import SwiftUI

@MainActor
final class MainViewModel: BaseViewModel {
    @Published private(set) var rockets = [Rocket]()

    func loadRockets() async {
        state = .loading
        do {
            var urlRequest = URLRequest(url: URL(string: "https://api.spacexdata.com/v4/rockets/query")!)

            urlRequest.httpMethod = "POST"
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

            urlRequest.httpBody = Queries.rockets

            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let result = try JSONDecoder().decode(RocketDataDTO.self, from: data)
            rockets = result.docs.map {
                Rocket(dto: $0)
            }

            state = rockets.isEmpty ? .error("Список ракет пуст") : .loaded
        } catch {
            print(error)
            state = .error(error.localizedDescription)
        }
    }
}
