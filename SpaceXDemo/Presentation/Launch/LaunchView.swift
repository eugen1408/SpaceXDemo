//
//  LaunchView.swift
//  SpaceXDemo
//
//  Created by Evgeniy Vaganov on 22.02.2022.
//

import SwiftUI

struct LaunchView: View {
    @ObservedObject var model: LaunchViewModel

    var body: some View {

        VStack(spacing: 32) {
            switch model.state {
            case .loaded:
                launchesView
            case .error(let errorText):
                Text(errorText)
                Button("Повторить загрузку") {
                    Task {
                        await model.loadLaunches()
                    }
                }
            default:
                ProgressView()
                Text("Загрузка списка запусков...")
            }

        }
        .task {
            await model.loadLaunches()
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    var launchesView: some View {
        if model.launches.isEmpty {
            Text("У этой ракеты пока не было запусков.")
        }
        else {
            List(model.launches) {
                Text($0.name)
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(model: LaunchViewModel(rocketId: "5e9d0d95eda69955f709d1eb"))
    }
}
