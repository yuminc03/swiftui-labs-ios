//
//  SpecifyingViewHierarchy.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/15.
//

import SwiftUI

struct SpecifyingViewHierarchy: View {
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

struct SpecifyingViewHierarchy_Previews: PreviewProvider {
    static var previews: some View {
        SpecifyingViewHierarchy()
    }
}
