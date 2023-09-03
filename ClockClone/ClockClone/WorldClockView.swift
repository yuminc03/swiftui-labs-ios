//
//  WorldClockCore.swift
//  ClockClone
//
//  Created by Yumin Chu on 2023/09/03.
//

import SwiftUI

import ComposableArchitecture

struct WorldClockCore: Reducer {
  struct State: Equatable {
    var selectedTabIndex = 0
    let tabItems = TabItem.allCases
  }
  
  enum Action {
    case didTapTabItem
  }
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    return .none
  }
}

struct WorldClockView: View {
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

struct WorldClockView_Previews: PreviewProvider {
  static var previews: some View {
    WorldClockView()
  }
}
