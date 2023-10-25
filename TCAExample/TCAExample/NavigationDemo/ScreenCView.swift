//
//  ScreenCView.swift
//  TCAExample
//
//  Created by Yumin Chu on 2023/10/25.
//

import SwiftUI

import ComposableArchitecture

struct ScreenCCore: Reducer {
  struct State: Codable, Equatable, Hashable {
    var count = 0
    var isTimerRunning = false
  }
  
  enum Action {
    case didTapStartButton
    case didTapStopButton
    case timerTicked
  }
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case .didTapStartButton:
      return .none
      
    case .didTapStopButton:
      return .none
      
    case .timerTicked:
      return .none
    }
  }
}

struct ScreenCView: View {
  private let store: StoreOf<ScreenCCore>
  @ObservedObject private var viewStore: ViewStoreOf<ScreenCCore>
  
  init() {
    self.store = .init(initialState: ScreenCCore.State()) {
      ScreenCCore()
    }
    self.viewStore = .init(store, observe: { $0 })
  }
  
  var body: some View {
    Form {
      Section {
        Text("\(viewStore.count)")
        if viewStore.isTimerRunning {
          Button("Stop timer") {
            viewStore.send(.didTapStopButton)
          }
        } else {
          Button("Start timer") {
            viewStore.send(.didTapStartButton)
          }
        }
      }
      
      Section {
//        NavigationLink("Go to screen A", state: NavigationDemoCore)
      }
    }
    .navigationTitle("Screen C")
  }
}

struct ScreenCView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      ScreenCView()
    }
  }
}
