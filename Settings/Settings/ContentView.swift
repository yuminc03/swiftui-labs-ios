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
    }
    
    var body: some View {
        NavigationView {
            Form {
                ForEach(viewStore.settings) { setting in
                    SettingsRow(setting: setting)
                }
            }
            
            .navigationTitle("설정")
        }
//        .alert(
//            store: store.scope(
//                state: \.$airplainModeAlert,
//                action: { .airplainModeAlert($0) }
//            ),
//            state: /SettingsReducer.Action.airplainModeAlert,
//            action: SettingsReducer.Action.airplainModeAlert
//        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
