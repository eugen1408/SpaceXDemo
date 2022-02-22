//
//  LaunchViewModel.swift
//  SpaceXDemo
//
//  Created by Evgeniy Vaganov on 22.02.2022.
//

import Foundation

@MainActor
final class LaunchViewModel: BaseViewModel {
    let rocketId: String
    @Published private(set) var launches = [Launch]()
    @Published var showError: Bool = false

    internal init(rocketId: String) {
        self.rocketId = rocketId
    }

    func loadLaunches() async {
        state = .loading
        do {
            var urlRequest = URLRequest(url: URL(string: "https://api.spacexdata.com/v4/launches/query")!)

            urlRequest.httpMethod = "POST"
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

            urlRequest.httpBody = Queries.launch(rocketId: rocketId)

            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let result = try decoder.decode(LaunchDataDTO.self, from: data)
            launches = result.docs.map {
                Launch(dto: $0)
            }
            state = .loaded
        } catch {
            print(error)
            state = .error(error.localizedDescription)
            showError = true
        }
    }
}
