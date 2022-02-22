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
                }
            }
            .edgesIgnoringSafeArea(.top)
            .navigationBarHidden(true)
        }
        .task {
            await model.loadRockets()
        }
    }

    var rocketsView: some View {
        TabView {
            ForEach(model.rockets) {
                RocketView(rocket: $0)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))

    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.dark)
    }
}
