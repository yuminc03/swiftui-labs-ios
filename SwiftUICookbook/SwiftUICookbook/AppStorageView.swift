//
//  AppStorageView.swift
//  SwiftUICookbook
//
//  Created by Yumin Chu on 2023/09/17.
//

import SwiftUI

struct AppStorageView: View {
  @AppStorage("username") var username = "Anonymous"
  @SceneStorage("selectedTab") var selectedTab: String?
  
  var body: some View {
    VStack {
      Text("Welcome, \(username)!")
      Button("Login") {
        username = "Yumin"
      }
      Spacer()
      TabView(selection: $selectedTab) {
        Text("Tab 1")
          .tabItem {
            Label("Tab 1", systemImage: "1.circle")
          }
          .tag("Tab1")
        
        Text("Tab 2")
          .tabItem {
            Label("Tab 2", systemImage: "2.circle")
          }
          .tag("Tab2")
      }
    }
  }
}

struct AppStorageView_Previews: PreviewProvider {
  static var previews: some View {
    AppStorageView()
  }
}
