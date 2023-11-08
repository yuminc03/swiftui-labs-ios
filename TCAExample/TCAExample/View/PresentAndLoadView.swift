//
//  PresentAndLoadView.swift
//  TCAExample
//
//  Created by Yumin Chu on 2023/10/26.
//

import SwiftUI

import ComposableArchitecture

struct PresentAndLoadCore: Reducer {
  struct State: Equatable {
    var counter: CounterCore.State?
    var isSheetPresented = false
  }
  
  enum Action {
    case setSheet(isPresented: Bool)
    case counter(CounterCore.Action)
    case setSheetIsDelayCompleted
  }
  
  @Dependency(\.continuousClock) var clock
  private enum CancelID {
    case load
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .setSheet(isPresented: true):
        state.isSheetPresented = true
        return .run { send in
          try await clock.sleep(for: .seconds(1))
          await send(.setSheetIsDelayCompleted)
        }
        .cancellable(id: CancelID.load)
        
      case .setSheet(isPresented: false):
        state.isSheetPresented = false
        state.counter = nil
        return .cancel(id: CancelID.load)
        
      case .setSheetIsDelayCompleted:
        state.counter = CounterCore.State()
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

struct PresentAndLoadView: View {
  private let store: StoreOf<PresentAndLoadCore>
  @ObservedObject private var viewStore: ViewStoreOf<PresentAndLoadCore>
  
  init() {
    self.store = .init(initialState: PresentAndLoadCore.State()) {
      PresentAndLoadCore()
    }
    self.viewStore = .init(store, observe: { $0 })
  }
  
  var body: some View {
    Form {
      Button("Load optinoal counter") {
        store.send(.setSheet(isPresented: true))
      }
    }
    .sheet(
      isPresented: viewStore.binding(
        get: \.isSheetPresented,
        send: { .setSheet(isPresented: $0)}
      )) {
        IfLetStore(
          store.scope(
            state: \.counter,
            action: { .counter($0) }
          )
        ) { store in
          CounterView(store: store)
        } else: {
          ProgressView()
        }
      }
    .navigationTitle("Present and load")
  }
}

struct PresentAndLoadView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      PresentAndLoadView()
    }
  }
}
