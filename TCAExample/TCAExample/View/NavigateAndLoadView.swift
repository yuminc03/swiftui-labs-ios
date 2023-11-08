//
//  NavigateAndLoadView.swift
//  TCAExample
//
//  Created by Yumin Chu on 2023/10/23.
//

import SwiftUI

import ComposableArchitecture

struct NavigateAndLoadCore: Reducer {
  struct State: Equatable {
    var isNavigationEnabled = false
    var counter: CounterCore.State?
  }
  
  enum Action {
    case counter(CounterCore.Action)
    case setNavigation(isActive: Bool)
    case setNavigationDelayCompleted
  }
  
  @Dependency(\.continuousClock) var clock
  private enum CancelID {
    case load
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .counter:
        return .none
        
      case .setNavigation(isActive: true):
        state.isNavigationEnabled = true
        return .run { send in
          try await clock.sleep(for: .seconds(1))
          await send(.setNavigationDelayCompleted)
        }
        .cancellable(id: CancelID.load)
        
      case .setNavigation(isActive: false):
        state.isNavigationEnabled = false
        state.counter = nil
        return .cancel(id: CancelID.load)
        
      case .setNavigationDelayCompleted:
        state.counter = CounterCore.State()
        return .none
      }
    }
    .ifLet(\.counter, action: /Action.counter) {
      CounterCore()
    }
  }
}

struct NavigateAndLoadView: View {
  private let store: StoreOf<NavigateAndLoadCore>
  @ObservedObject private var viewStore: ViewStoreOf<NavigateAndLoadCore>
  
  init() {
    self.store = .init(initialState: NavigateAndLoadCore.State()) {
      NavigateAndLoadCore()
    }
    self.viewStore = .init(store, observe: { $0 })
  }
  
  var body: some View {
    Form {
      NavigationLink(
        "Load optional counter",
        isActive: viewStore.binding(
          get: \.isNavigationEnabled,
          send: { .setNavigation(isActive: $0) }
        )
      ) {
        IfLetStore(
          store.scope(
            state: \.counter,
            action: { .counter($0) }
          )
        ) {
          CounterView(store: $0)
        } else: {
          ProgressView()
        }
      }
    }
    .navigationTitle("Navigate and load")
  }
}

struct NavigateAndLoadView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      NavigateAndLoadView()
    }
  }
}
