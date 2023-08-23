//
//  LandmarksView.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/22.
//

import SwiftUI

struct LandmarksView: View {
  @State private var selected: Tab = .featured
  
  enum Tab {
    case featured
    case list
  }
  
  var body: some View {
    TabView(selection: $selected) {
      CategoryHome()
        .tabItem {
          Label("Featured", systemImage: "star")
        }
        .tag(Tab.featured)
      
      LandmarkList()
        .tabItem {
          Label("List", systemImage: "list.bullet")
        }
        .tag(Tab.list)
    }
  }
}

struct LandmarksView_Previews: PreviewProvider {
  static var previews: some View {
    LandmarksView()
      .environmentObject(ModelData())
  }
}
