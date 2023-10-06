//
//  ContentView.swift
//  TCAFruitScore
//
//  Created by Yumin Chu on 2023/10/06.
//

import SwiftUI

import ComposableArchitecture

struct ContentCore: Reducer {
  struct State: Equatable {
    
  }
  
  enum Action {
    
  }
  
}
struct ContentView: View {
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
    ContentView()
  }
}
