//
//  BaseViewModel.swift
//  SpaceXDemo
//
//  Created by Evgeniy Vaganov on 22.02.2022.
//

import Foundation

class BaseViewModel: ObservableObject {
    @Published var state: State?

    enum State: Equatable {
        case loading
        case loaded
        case error(String)
    }

    var errorText: String {
        switch state {
        case .error(let errorText):
            return errorText
        default:
            return String()
        }
    }
}
