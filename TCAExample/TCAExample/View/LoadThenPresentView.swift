//
//  LoadThenPresentView.swift
//  TCAExample
//
//  Created by Yumin Chu on 2023/10/26.
//

import SwiftUI

import ComposableArchitecture

struct LoadThenPresentCore: Reducer {
  struct State: Equatable {
    var isLoading = false
    @PresentationState var counter: CounterCore.State?
  }
  
  enum Action {
    case didTapLoadButton
    case counter(PresentationAction<CounterCore.Action>)
    case counterPresentationDelayCompleted
  }
  
  @Dependency(\.continuousClock) var clock
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .didTapLoadButton:
        state.isLoading = true
        return .run { send in
          try await clock.sleep(for: .seconds(1))
          await send(.counterPresentationDelayCompleted)
        }
        
      case .counter:
        return .none
        
      case .counterPresentationDelayCompleted:
        state.isLoading = false
        state.counter = CounterCore.State()
        return .none
      }
    }
    .ifLet(\.$counter, action: /Action.counter) {
      CounterCore()
    }
  }
}

struct LoadThenPresentView: View {
  private let store: StoreOf<LoadThenPresentCore>
  @ObservedObject private var viewStore: ViewStoreOf<LoadThenPresentCore>
  
  init() {
    self.store = .init(initialState: LoadThenPresentCore.State()) {
      LoadThenPresentCore()
    }
    self.viewStore = .init(store, observe: { $0 })
  }
  
  var body: some View {
    Form {
      Button {
        store.send(.didTapLoadButton)
      } label: {
        HStack {
          Text("Load optional counter")
          if viewStore.isLoading {
            Spacer()
            ProgressView()
          }
        }
      }
    }
    .sheet(store: store.scope(state: \.$counter, action: { .counter($0) })) { store in
      CounterView(store: store)
    }
    .navigationTitle("Load and present")
  }
}

struct LoadThenPresentView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      LoadThenPresentView()
    }
  }
}
