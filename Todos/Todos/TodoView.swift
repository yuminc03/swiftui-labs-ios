//
//  TodoView.swift
//  Todos
//
//  Created by Yumin Chu on 2023/10/30.
//

import SwiftUI

import ComposableArchitecture

struct TodoCore: Reducer {
  struct State: Equatable, Identifiable {
    let id: UUID
    @BindingState var description = ""
    @BindingState var isComplete = false
  }
  
  enum Action: BindableAction, Sendable {
    case binding(BindingAction<State>)
    case didTapCheckButton
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .didTapCheckButton:
        state.$isComplete.wrappedValue.toggle()
        return .none
        
      default:
        return .none
      }
    }
  }
}

struct TodoView: View {
  private let store: StoreOf<TodoCore>
  @ObservedObject private var viewStore: ViewStoreOf<TodoCore>
  
  init(store: StoreOf<TodoCore>) {
    self.store = store
    self.viewStore = .init(store, observe: { $0 })
  }
  
  var body: some View {
    HStack {
      Button {
        store.send(.didTapCheckButton)
      } label: {
        Image(systemName: viewStore.isComplete ? "checkmark.square": "square")
      }
      .buttonStyle(.plain)
      
      TextField("Untitled Todo", text: viewStore.$description)
    }
    .foregroundColor(viewStore.isComplete ? .gray : nil)
  }
}

struct TodoView_Previews: PreviewProvider {
  static var previews: some View {
    TodoView(store: .init(initialState: TodoCore.State(
      id: UUID(),
      description: "Check Mail",
      isComplete: false
    )) {
      TodoCore()
        ._printChanges()
    })
    .previewLayout(.sizeThatFits)
  }
}
