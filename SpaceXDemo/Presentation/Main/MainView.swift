//
//  ContentView.swift
//  SpaceXDemo
//
//  Created by Evgeniy Vaganov on 21.02.2022.
//

import SwiftUI

struct MainView: View {

    @StateObject var model = MainViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 32) {
                switch model.state {
                case .loaded:
                    rocketsView
                case .error(let errorText):
                    Text(errorText)
                    Button("Повторить загрузку") {
                        Task {
                            await model.loadRockets()
                        }
                    }
                default:
                    ProgressView()
                    Text("Загрузка списка рокет...")
                }

            }
        }
        .task {
            await model.loadRockets()
        }
    }

    var rocketsView: some View {
        TabView {
            ForEach(model.rockets) { rocket in
                VStack {
                    Text(rocket.id).textSelection(.enabled)
                    Text(rocket.name)

                    NavigationLink {
                        LaunchView(model: LaunchViewModel(rocketId: rocket.id))
                            .navigationTitle(rocket.name)
                    } label: {
                        Text("Посмотреть запуски")
                    }
                }

            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
