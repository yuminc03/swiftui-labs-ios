//
//  SwiftUIPractiseExtampleApp.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/04/18.
//

import SwiftUI

@main
struct SwiftUIPractiseExtampleApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
//        #if os(iOS)
//        WindowGroup {
//            TabView {
//                ContentView()
//                    .tabItem {
//                        Label("Journal", systemImage: "book")
//                    }
//
//                SettingsView()
//                    .tabItem {
//                        Label("Settings", systemImage: "gear")
//                    }
//            }
//        }
//        #elseif os(macOS)
//        WindowGroup {
//            AlternativeContentView()
//        }
//
//        Settings {
//            SettingsView()
//        }
//        #endif
    }
}
