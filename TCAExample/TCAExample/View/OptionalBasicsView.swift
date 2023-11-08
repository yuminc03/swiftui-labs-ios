//
//  OptionalBasicsView.swift
//  TCAExample
//
//  Created by Yumin Chu on 2023/10/16.
//

import SwiftUI

import ComposableArchitecture

struct OptionalBasicsCore: Reducer {
  struct State: Equatable {
    var counter: CounterCore.State?
  }
  
  enum Action {
    case didTapToggleCounterButton
    case counter(CounterCore.Action)
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .didTapToggleCounterButton:
        state.counter = state.counter == nil ? CounterCore.State() : nil
        return .none
        
      case .counter:
        return .none
      }
    }
    .ifLet(\.counter, action: /Action.counter) {
      CounterCore()
    }
  }
}

struct OptionalBasicsView: View {
  private let store: StoreOf<OptionalBasicsCore>
  @ObservedObject private var viewStore: ViewStoreOf<OptionalBasicsCore>
  
  init() {
    self.store = .init(initialState: OptionalBasicsCore.State()) {
      OptionalBasicsCore()
    }
    self.viewStore = .init(store, observe: { $0 })
  }
  
  var body: some View {
    Form {
      Button("Toggle counter state") {
        store.send(.didTapToggleCounterButton)
      }
      
      IfLetStore(store.scope(state: \.counter, action: { .counter($0) })) { store in
        Text("CounterState is non-nil")
        CounterView(store: store)
          .buttonStyle(.borderless)
          .frame(maxWidth: .infinity)
      } else: {
        Text("CounterState is nil")
      }
    }
    .navigationTitle("Optinoal state")
  }
}

struct OptionalBasicsView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      OptionalBasicsView()
    }
  }
}
