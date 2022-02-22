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
        } else {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 16) {
                    ForEach(model.launches) {
                        LaunchCellView(launch: $0)
                    }
                }
            }
        }
    }
}

struct LaunchCellView: View {
    let launch: Launch

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(launch.name)
                Text(launch.date)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            if let success = launch.success {
                Text("🚀")
                    .rotationEffect(success ? .zero : .degrees(180))
            } else {
                Text("⏳")
            }
        }
        .padding(24)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .padding(.horizontal)
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchCellView(launch: Launch(dto: LaunchDTO(
            id: "abc",
            success: true,
            name: "Name",
            dateLocal: Date()
        )))
    }
}
