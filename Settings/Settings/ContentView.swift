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
    
    init(store: StoreOf<SettingsReducer>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }
    
    var body: some View {
        NavigationStackStore(store.scope(state: \.path, action: { .path($0) })) {
            Form {
                Section {
                    ProfileView(
                        imageName: "char_yumin",
                        nameText: "Yumin Chu",
                        description: "Apple ID, iCloud+, 미디어 및 구입 항목"
                    )
                }
                Section {
                    ForEach(viewStore.section1) { settingsItem in
                        NavigationLink(state: SettingsDetailReducer.State(item: settingsItem)) {
                            SettingsRow(item: settingsItem)
                        }
                    }
                }
                Section {
                    ForEach(viewStore.section2) { settingItem in
                        if settingItem == .airplane {
                            ToggleView(store: store.scope(state: \.toggleState, action: SettingsReducer.Action.toggleAction))
                        } else {
                            NavigationLink(state: SettingsDetailReducer.State(item: settingItem)) {
                                SettingsRow(item: settingItem)
                            }
                        }
                    }
                }
                Section {
                    ForEach(viewStore.section3) { settingItem in
                        NavigationLink(state: SettingsDetailReducer.State(item: settingItem)) {
                            SettingsRow(item: settingItem)
                        }
                    }
                }
            }
            
            .navigationTitle("설정")
            .searchable(
                text: viewStore.binding(
                    get: \.searchBarText,
                    send: SettingsReducer.Action.didChangeSearchBarText
                ),
                prompt: "검색"
            )
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
        ContentView(store: .init(initialState: .init()) {
            SettingsReducer()
        })
    }
}
