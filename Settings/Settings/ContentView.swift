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
                ._printChanges()
        }
        self.viewStore = ViewStore(store, observe: { $0 })
        UITableViewHeaderFooterView.appearance().tintColor = UIColor.clear
    }
    
    var body: some View {
        NavigationStackStore(
            store.scope(state: \.path, action: { .path($0) })
        ) {
            Form {
                Section {
                    SearchBarView(store: store.scope(
                        state: \.searchBar,
                        action: SettingsReducer.Action.searchBar
                    ))
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
                    NavigationLink(state: SettingsDetailReducer.State(setting: viewStore.settings[0])) {
                        SettingsRow(setting: viewStore.settings[0])
                    }
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
                            NavigationLink(state: SettingsDetailReducer.State(setting: viewStore.settings[index])) {
                                SettingsRow(setting: viewStore.settings[index])
                            }
                        }
                    }
                }
                Section {
                    ForEach(7 ..< viewStore.settings.endIndex) { index in
                        NavigationLink(state: SettingsDetailReducer.State(setting: viewStore.settings[index])) {
                            SettingsRow(setting: viewStore.settings[index])
                        }
                    }
                }
            }
            
            .navigationTitle("설정")
        } destination: { store in
            SettingsDetailView(store: store)
        }
        .alert(
            store: store.scope(
                state: \.$destination,
                action: { .destination($0) }
            ),
            state: /SettingsReducer.Destination.State.airplainModeAlert,
            action: SettingsReducer.Destination.Action.airplainModeAlert
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
