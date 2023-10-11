//
//  RootView.swift
//  TCAExample
//
//  Created by Yumin Chu on 2023/10/10.
//

import SwiftUI

struct RootView: View {
  var body: some View {
    NavigationStack {
      Form {
        Section {
          NavigationLink {
            CounterDemoView()
          } label: {
            Text("Basics")
          }
          
        } header: {
          Text("Getting started")
        }
      }
      .navigationTitle("SwiftUI TCA")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    RootView()
  }
}
