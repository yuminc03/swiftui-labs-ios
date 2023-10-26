//
//  NavigateAndLoadListView.swift
//  TCAExample
//
//  Created by Yumin Chu on 2023/10/26.
//

import SwiftUI

import ComposableArchitecture

struct NavigateAndLoadListCore: Reducer {
  struct State: Equatable {
    var rows: IdentifiedArrayOf<Row> = [
      Row(id: UUID(), count: 1),
      Row(id: UUID(), count: 42),
      Row(id: UUID(), count: 100)
    ]
    var selection: Identified<Row.ID, CounterCore.State?>?
    
    struct Row: Equatable, Identifiable {
      let id: UUID
      var count: Int
    }
  }
  
  enum Action {
    case counter(CounterCore.Action)
    case setNavigation(selection: UUID?)
    case setNavigationSelectionDelayCompleted
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
        
      case let .setNavigation(selection: .some(id)):
        state.selection = Identified(nil, id: id)
        return .run { send in
          try await clock.sleep(for: .seconds(1))
          await send(.setNavigationSelectionDelayCompleted)
        }
        .cancellable(id: CancelID.load, cancelInFlight: true)
        
      case .setNavigation(selection: .none):
        if let selection = state.selection, let count = selection.value?.count {
          state.rows[id: selection.id]?.count = count
        }
        state.selection = nil
        return .cancel(id: CancelID.load)
        
      case .setNavigationSelectionDelayCompleted:
        guard let id = state.selection?.id else { return .none }
        state.selection?.value = CounterCore.State(count: state.rows[id: id]?.count ?? 0)
        return .none
      }
    }
    .ifLet(\State.selection, action: /Action.counter) {
      EmptyReducer()
        .ifLet(\Identified<State.Row.ID, CounterCore.State?>.value, action: .self) {
          CounterCore()
        }
    }
  }
}

struct NavigateAndLoadListView: View {
  private let store: StoreOf<NavigateAndLoadListCore>
  @ObservedObject private var viewStore: ViewStoreOf<NavigateAndLoadListCore>
  
  init() {
    self.store = .init(initialState: NavigateAndLoadListCore.State()) {
      NavigateAndLoadListCore()
    }
    self.viewStore = .init(store, observe: { $0 })
  }
  
  var body: some View {
    Form {
      ForEach(viewStore.rows) { row in
        NavigationLink(
          "Load optional counter that start form \(row.count)",
          tag: row.id,
          selection: viewStore.binding(
            get: \.selection?.id, send: { .setNavigation(selection: $0) })
        ) {
          IfLetStore(store.scope(
            state: \.selection?.value,
            action: { .counter($0) }
          )) { store in
            CounterView(store: store)
          } else: {
            ProgressView()
          }
        }
      }
    }
    .navigationTitle("Navigate and load")
  }
}

struct NavigateAndLoadListView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      NavigateAndLoadListView()
    }
  }
}
