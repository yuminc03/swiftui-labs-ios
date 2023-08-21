//
//  ContentView.swift
//  Settings
//
//  Created by Yumin Chu on 2023/08/20.
//

import SwiftUI

import ComposableArchitecture

struct ContentView: View {
    
    private let store: StoreOf<SettingsReducer>
    @ObservedObject private var viewStore: ViewStoreOf<SettingsReducer>
    
    init() {
        self.store = Store(initialState: SettingsReducer.State()) {
            SettingsReducer()
        }
        self.viewStore = ViewStore(store, observe: { $0 })
        UITableViewHeaderFooterView.appearance().tintColor = UIColor.clear
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    SearchBarView()
                        .padding(-20)
                }
                Section {
                    ProfileView(
                        imageName: "char_yumin",
                        nameText: "Yumin Chu",
                        description: "Apple ID, iCloud+, 미디어 및 구입 항목"
                    )
                }
                Section {
                    SettingsRow(setting: viewStore.settings[0])
                }
                Section {
                    ForEach(1 ..< 7) { index in
                        if index == 1 {
                            Toggle(
                                isOn: viewStore.binding(
                                    get: \.isAirplainSwitchOn,
                                    send: SettingsReducer.Action.didTapAirplainModeSwitch
                                )
                            ) {
                                SettingsRow(
                                    setting: viewStore.settings[index]
                                )
                            }
                        } else {
                            SettingsRow(setting: viewStore.settings[index])
                        }
                    }
                }
                Section {
                    ForEach(7 ..< viewStore.settings.endIndex) { index in
                        SettingsRow(setting: viewStore.settings[index])
                    }
                }
            }
            
            .navigationTitle("설정")
        }
        .alert(store: store.scope(
            state: \.$airplainModeAlert,
            action: { .airplainModeAlert($0) })
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
