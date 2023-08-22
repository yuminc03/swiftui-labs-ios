//
//  SettingsApp.swift
//  Settings
//
//  Created by Yumin Chu on 2023/08/20.
//

import SwiftUI

import ComposableArchitecture

@main
struct SettingsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(store: Store(initialState: .init()) {
                SettingsReducer()._printChanges()
            })
        }
    }
}
