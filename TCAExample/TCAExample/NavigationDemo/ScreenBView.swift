//
//  ScreenBView.swift
//  TCAExample
//
//  Created by Yumin Chu on 2023/10/25.
//

import SwiftUI

import ComposableArchitecture

struct ScreenBCore: Reducer {
  struct State: Codable, Equatable, Hashable { }
  
  enum Action {
    case didTapScreenAButton
    case didTapScreenBButton
    case didTapScreenCButton
  }
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case .didTapScreenAButton:
      return .none
      
    case .didTapScreenBButton:
      return .none
      
    case .didTapScreenCButton:
      return .none
    }
  }
}

struct ScreenBView: View {
  private let store: StoreOf<ScreenBCore>
  
  init(store: StoreOf<ScreenBCore>) {
    self.store = store
  }
  
  var body: some View {
    Form {
      Button("Decoupled navigation to screen A") {
        store.send(.didTapScreenAButton)
      }
      Button("Decoupled navigation to screen B") {
        store.send(.didTapScreenBButton)
      }
      Button("Decoupled navigation to screen C") {
        store.send(.didTapScreenCButton)
      }
    }
    .navigationTitle("Screen B")
  }
}

struct ScreenBView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      ScreenBView(store: .init(initialState: ScreenBCore.State()) {
        ScreenBCore()
      })
    }
  }
}
