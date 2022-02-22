//
//  SettingsView.swift
//  SpaceXDemo
//
//  Created by Evgeniy Vaganov on 22.02.2022.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss

    @AppStorage(Settings.heightDimensions.rawValue) private var height = LengthDimensions.m
    @AppStorage(Settings.diameterDimensions.rawValue) private var diameter = LengthDimensions.m
    @AppStorage(Settings.massDimensions.rawValue) private var mass = MassDimensions.kg
    @AppStorage(Settings.payloadDimensions.rawValue) private var payload = MassDimensions.kg

    var body: some View {
        VStack(spacing: 32) {
            Text("Настройки").padding()
            HStack {
                Text("Высота")
                Spacer()
                Picker("Высота", selection: $height) {
                    ForEach(LengthDimensions.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented).labelsHidden().frame(maxWidth: 120)
            }.padding(.horizontal)
            HStack {
                Text("Диаметр")
                Spacer()
                Picker("Диаметр", selection: $diameter) {
                    ForEach(LengthDimensions.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented).labelsHidden().frame(maxWidth: 120)
            }.padding(.horizontal)
            HStack {
                Text("Масса")
                Spacer()
                Picker("Масса", selection: $mass) {
                    ForEach(MassDimensions.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented).labelsHidden().frame(maxWidth: 120)
            }.padding(.horizontal)
            HStack {
                Text("Полезная нагрузка")
                Spacer()
                Picker("Полезная нагрузка", selection: $payload) {
                    ForEach(MassDimensions.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented).labelsHidden().frame(maxWidth: 120)
            }.padding(.horizontal)
            Spacer()
        }.overlay(alignment: .topTrailing) {
            Button("Закрыть") {
                dismiss()
            }
            .padding()
            .foregroundColor(.primary)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

enum LengthDimensions: String, CaseIterable {
    case m, ft
}

enum MassDimensions: String, CaseIterable {
    case kg, lb
}
