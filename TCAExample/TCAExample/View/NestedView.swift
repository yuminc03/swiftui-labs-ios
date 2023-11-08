//
//  NestedView.swift
//  TCAExample
//
//  Created by Yumin Chu on 2023/10/27.
//

import SwiftUI

import ComposableArchitecture

struct NestedCore: Reducer {
  struct State: Equatable, Identifiable {
    let id: UUID
    var name = ""
    var rows: IdentifiedArrayOf<State> = []
  }
  
  enum Action {
    case didTapAddRowButton
    case didChangedNameTextField(String)
    case onDelete(IndexSet)
    indirect case row(id: State.ID, action: Action)
  }
  
  @Dependency(\.uuid) var uuid
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .didTapAddRowButton:
        state.rows.append(State(id: uuid()))
        return .none
        
      case let .didChangedNameTextField(name):
        state.name = name
        return .none
        
      case let .onDelete(indexSet):
        state.rows.remove(atOffsets: indexSet)
        return .none
        
      case .row:
        return .none
      }
    }
    .forEach(\.rows, action: /Action.row) {
      Self()
    }
  }
}

extension NestedCore.State {
  static let mock = NestedCore.State(
    id: UUID(),
    name: "Foo",
    rows: [
      .init(id: UUID(), name: "Bar", rows: [
        .init(id: UUID(), name: "", rows: [])
      ]),
      .init(id: UUID(), name: "Baz", rows: [
        .init(id: UUID(), name: "Fizz", rows: []),
        .init(id: UUID(), name: "Buzz", rows: [])
      ]),
      .init(id: UUID(), name: "", rows: [])
    ]
  )
}

struct NestedView: View {
  private let store: StoreOf<NestedCore>
  @ObservedObject private var viewStore: ViewStore<String, NestedCore.Action>
  
  init(store: StoreOf<NestedCore>) {
    self.store = store
    self.viewStore = .init(store, observe: \.name)
  }
  
  var body: some View {
    Form {
      ForEachStore(store.scope(
        state: \.rows,
        action: { .row(id: $0, action: $1) }
      )) { rowStore in
        let rowViewStore = ViewStore(rowStore, observe: \.name)
        NavigationLink {
          NestedView(store: rowStore)
        } label: {
          HStack {
            TextField("Untitled", text: rowViewStore.binding(
              send: { .didChangedNameTextField($0) }
            ))
            Text("Next")
              .font(.callout)
              .foregroundStyle(.secondary)
          }
        }
      }
      .onDelete {
        store.send(.onDelete($0))
      }
    }
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button("Add row") {
          store.send(.didTapAddRowButton)
        }
      }
    }
    .navigationTitle(viewStore.state.isEmpty ? "Untitled" : viewStore.state)
  }
}

struct NestedView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      NestedView(store: .init(initialState: .mock) {
        NestedCore()
      })
    }
  }
}
