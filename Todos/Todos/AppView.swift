//
//  AppView.swift
//  Todos
//
//  Created by Yumin Chu on 2023/10/30.
//

import SwiftUI

struct AppView: View {
  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundColor(.accentColor)
      Text("Hello, world!")
    }
    .padding()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    AppView()
  }
}
