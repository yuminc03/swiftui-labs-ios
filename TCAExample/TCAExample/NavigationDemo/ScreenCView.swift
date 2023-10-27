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
  
  @Dependency(\.mainQueue) var mainQueue
  private enum CancelID {
    case timer
  }
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case .didTapStartButton:
      state.isTimerRunning = true
      return .run { send in
        for await _ in mainQueue.timer(interval: 1) {
          await send(.timerTicked)
        }
      }
      .cancellable(id: CancelID.timer)
      .concatenate(with: .send(.didTapStopButton))
      
    case .didTapStopButton:
      state.isTimerRunning = false
      return .cancel(id: CancelID.timer)
      
    case .timerTicked:
      state.count += 1
      return .none
    }
  }
}

struct ScreenCView: View {
  private let store: StoreOf<ScreenCCore>
  @ObservedObject private var viewStore: ViewStoreOf<ScreenCCore>
  
  init(store: StoreOf<ScreenCCore>) {
    self.store = store
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
        NavigationLink(
          "Go to screen A",
          state: NavigationDemoCore.Path.State.screenA(
            ScreenACore.State(count: viewStore.count)
          )
        )
        NavigationLink(
          "Go to screen B",
          state: NavigationDemoCore.Path.State.screenB()
        )
        NavigationLink(
          "Go to screen C",
          state: NavigationDemoCore.Path.State.screenC()
        )
      }
    }
    .navigationTitle("Screen C")
  }
}

struct ScreenCView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      ScreenCView(store: .init(initialState: ScreenCCore.State()) {
        ScreenCCore()
      })
    }
  }
}
