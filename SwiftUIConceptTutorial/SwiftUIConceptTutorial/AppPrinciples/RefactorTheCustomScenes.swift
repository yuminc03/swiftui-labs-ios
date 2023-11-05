//
//  RefactorTheCustomScenes.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/15.
//

import SwiftUI

struct RefactorTheCustomScenes: View {
    var body: some View {
        #if os(iOS)
        RefactoriOSView()
        #elseif os(macOS)
        RefactorMacOSView()
        #endif
    }
}

struct RefactorTheCustomScenes_Previews: PreviewProvider {
    static var previews: some View {
        RefactorTheCustomScenes()
    }
}

struct RefactoriOSView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Journal", systemImage: "book")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

struct RefactorMacOSView: View {
    var body: some View {
        AlternativeContentView()
        
        #if os(macOS)
        Settings {
            SettingsView()
        }

        #endif
    }
}
