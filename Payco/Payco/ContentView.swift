//
//  ContentView.swift
//  Payco
//
//  Created by Yumin Chu on 2023/08/26.
//

import SwiftUI

import ComposableArchitecture

struct ContentCore: Reducer {
  struct State: Equatable {
    var selectedIndex = 0
  }
  
  enum Action {
    case didTapTabItem
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .didTapTabItem:
        return .none
      }
    }
  }
}

struct ContentView: View {
  var body: some View {
    NavigationView {
      List {
        Section {
          HStack(spacing: 10) {
            title
            Spacer()
            TopRightButton(imageName: "ticket")
            TopRightButton(imageName: "bell")
            TopRightButton(imageName: "person")
          }
        }
        
        .listRowSeparator(.hidden)
      }
      .listStyle(.plain)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

extension ContentView {
  
  var title: some View {
    Text("포인트")
      .font(.title)
      .bold()
  }
  
  
}
