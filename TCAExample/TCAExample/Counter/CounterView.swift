//
//  CounterView.swift
//  TCAExample
//
//  Created by Yumin Chu on 2023/10/10.
//

import SwiftUI

import ComposableArchitecture

struct CounterCore: Reducer {
  struct State: Equatable {
    var count = 0
  }
  
  enum Action {
    case didTapMinusButton
    case didTapPlusButton
  }
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case .didTapMinusButton:
      state.count -= 1
      return .none
      
    case .didTapPlusButton:
      state.count += 1
      return .none
    }
  }
}

struct CounterDemoView: View {
  private let store: StoreOf<CounterCore>
  
  init() {
    let store = Store(initialState: CounterCore.State()) {
      CounterCore()
    }
    self.store = store
  }
  
  var body: some View {
    Form {
      Section {
        CounterView(store: store)
          .frame(maxWidth: .infinity)
      }
    }
    .buttonStyle(.borderless)
    .navigationTitle("Counter")
  }
}

struct CounterView: View {
  private let store: StoreOf<CounterCore>
  @ObservedObject private var viewStore: ViewStoreOf<CounterCore>
  
  init(store: StoreOf<CounterCore>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: { $0 })
  }
  
  var body: some View {
    HStack(spacing: 10) {
      Button {
        store.send(.didTapMinusButton)
      } label: {
        Image(systemName: "minus")
      }
      Text("\(viewStore.count)")
        .monospacedDigit()
      Button {
        store.send(.didTapPlusButton)
      } label: {
        Image(systemName: "plus")
      }
    }
  }
}

struct CounterDemoView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      CounterDemoView()
    }
  }
}
