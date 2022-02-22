//
//  RocketView.swift
//  SpaceXDemo
//
//  Created by Evgeniy Vaganov on 22.02.2022.
//

import SwiftUI

struct RocketView: View {

    @AppStorage(Settings.heightDimensions.rawValue) private var height = LengthDimensions.m
    @AppStorage(Settings.diameterDimensions.rawValue) private var diameter = LengthDimensions.m
    @AppStorage(Settings.massDimensions.rawValue) private var mass = MassDimensions.kg
    @AppStorage(Settings.payloadDimensions.rawValue) private var payload = MassDimensions.kg
    /// @AppStorage периодически не обновляется, это хак для force update
    @State var refresh: Bool = false

    @State private var showLaunchRocketId: String?
    @State var showSettings = false
    let rocket: Rocket

    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                ZStack(alignment: .top) {
                    AsyncImage(
                        url: rocket.selectedImage,
                        transaction: Transaction(animation: .easeInOut)) { image in
                            switch image {
                            case .empty:
                                ProgressView().padding(64)
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: proxy.size.width, height: proxy.size.height / 2, alignment: .center)
                                    .transition(.opacity)
                            case .failure:
                                Image(systemName: "xmark.octagon.fill").padding(64)
                            @unknown default:
                                EmptyView()
                            }
                        }

                    VStack(alignment: .leading, spacing: 16) {
                        titleView
                        mainSpecsView
                        specsView
                        launchViewButton
                    }
                    .frame(maxWidth: proxy.size.width, minHeight: proxy.size.height / 2, maxHeight: .infinity, alignment: .leading)
                    .background(.thinMaterial)
                    .cornerRadius(32, corners: [.topLeft, .topRight])
                    .padding(.top, proxy.size.height / 2 - 50)
                }

            }
            .sheet(isPresented: $showSettings) {
                refresh.toggle()
            } content: {
                SettingsView()
            }
        }
    }

    var titleView: some View {
        HStack {
            Text(rocket.name)
                .font(.title)
            Spacer()
            Button {
                showSettings = true
            } label: {
                Image(systemName: "gearshape")
                    .font(.title2)
                    .foregroundColor(.primary)
            }
        }
        .padding(.top, 32)
        .padding(.horizontal)
    }

    var mainSpecsView: some View {
        ScrollView(.horizontal) {
            HStack {
                MainSpecCell(entry: height == .m
                             ? .init(text: "Высота, m", value: String(rocket.height.meters))
                             : .init(text: "Высота, ft", value: String(rocket.height.feet)))

                MainSpecCell(entry: diameter == .m
                             ? .init(text: "Диаметр, m", value: String(rocket.diameter.meters))
                             : .init(text: "Диаметр, ft", value: String(rocket.diameter.feet)))

                MainSpecCell(entry: mass == .kg
                             ? .init(text: "Масса, kg", value: String(rocket.mass.kg))
                             : .init(text: "Масса, lb", value: String(rocket.mass.lb)))

                if let payloadWeight = rocket.payloadWeight {
                    MainSpecCell(entry: payload == .kg
                                 ? .init(text: "Нагрузка, kg", value: String(payloadWeight.kg))
                                 : .init(text: "Нагрузка, lb", value: String(payloadWeight.lb)))
                }
            }
            .padding(.horizontal)
        }
    }

    struct MainSpecCell: View {
        let entry: Rocket.SpecsEntry
        var body: some View {

            VStack {
                Text(entry.value)
                    .bold()
                Text(entry.text)
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal)
            .padding(.vertical, 24)
            .background(Color(.systemGray5))
            .clipShape(RoundedRectangle(cornerRadius: 32))
        }
    }

    var specsView: some View {
        ForEach(rocket.specs, id: \.self) { group in
            VStack(alignment: .leading, spacing: 16) {
                if let title = group.title {
                    Text(title)
                        .bold()
                        .textCase(.uppercase)
                        .padding(.horizontal)
                }
                ForEach(group.entries, id: \.self) { entry in
                    HStack {
                        Text(entry.text)
                        Spacer()
                        Text(entry.value)
                            .bold()
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.bottom, 16)
        }
    }

    @MainActor
    var launchViewButton: some View {
        NavigationLink(destination: LaunchView(model: LaunchViewModel(rocketId: rocket.id))
                        .navigationTitle(rocket.name), tag: rocket.id, selection: $showLaunchRocketId) {
        Button {
            showLaunchRocketId = rocket.id
        } label: {
            Text("Посмотреть запуски")
                .foregroundColor(.primary)
                .bold()
                .frame(maxWidth: .infinity)
        }
        .controlSize(.large)
        .buttonStyle(.bordered)
        .tint(.secondary)
        }
        .padding(.horizontal)
        .padding(.bottom, 48)
    }
}
