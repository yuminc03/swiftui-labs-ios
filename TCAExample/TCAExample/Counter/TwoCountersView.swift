//
//  TwoCountersView.swift
//  TCAExample
//
//  Created by Yumin Chu on 2023/10/11.
//

import SwiftUI

import ComposableArchitecture

struct TwoCountersCore: Reducer {
  struct State: Equatable {
    var topCounter = CounterCore.State()
    var bottomCounter = CounterCore.State()
  }
  
  enum Action {
    case topCounter(CounterCore.Action)
    case bottomCounter(CounterCore.Action)
  }
  
  var body: some Reducer<State, Action> {
    Scope(state: \.topCounter, action: /Action.topCounter) {
      CounterCore()
    }
    Scope(state: \.bottomCounter, action: /Action.bottomCounter) {
      CounterCore()
    }
  }
}

struct TwoCountersView: View {
  private let store: StoreOf<TwoCountersCore>
  @ObservedObject private var viewStore: ViewStoreOf<TwoCountersCore>
  
  init() {
    let store = Store(initialState: TwoCountersCore.State()) {
      TwoCountersCore()
    }
    self.store = store
    self.viewStore = ViewStore(store, observe: { $0 })
  }
  
  var body: some View {
    Form {
      HStack {
        Text("Top Counter")
        Spacer()
        CounterView(
          store: store.scope(
            state: \.topCounter,
            action: { .topCounter($0) }
          )
        )
      }
     
      HStack {
        Text("Bottom Counter")
        Spacer()
        CounterView(
          store: store.scope(
            state: \.bottomCounter,
            action: { .bottomCounter($0) }
          )
        )
      }
    }
    .buttonStyle(.borderless)
    .navigationTitle("Two Counters")
  }
}

struct TwoCountersView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      TwoCountersView()
    }
  }
}
