//
//  AppView.swift
//  Todos
//
//  Created by Yumin Chu on 2023/10/30.
//

import SwiftUI

import ComposableArchitecture

enum Filter: LocalizedStringKey, CaseIterable, Hashable {
  case all = "All"
  case active = "Active"
  case completed = "Completed"
}

struct AppCore: Reducer {
  struct State: Equatable {
    @BindingState var editMode: EditMode = .inactive
    @BindingState var filter: Filter = .all
    var todos: IdentifiedArrayOf<TodoCore.State> = []
    
    var filteredTodos: IdentifiedArrayOf<TodoCore.State> {
      switch filter {
      case .all:
        return todos.filter { $0.isComplete == false }
        
      case .active:
        return todos
        
      case .completed:
        return todos.filter(\.isComplete)
      }
    }
  }
  
  enum Action: BindableAction, Sendable {
    case binding(BindingAction<State>)
    case deleteRow(IndexSet)
    case moveRow(IndexSet, Int)
    case didTapClearCompleteButton
    case didTapAddTodoButton
    case todoRowAction(id: TodoCore.State.ID, action: TodoCore.Action)
    case sortCompletedTodos
  }
  
  @Dependency(\.continuousClock) var clock
  @Dependency(\.uuid) var uuid
  private enum CancelID {
    case todoCompletion
  }
  
  var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
        
      case let .deleteRow(indexSet):
        let filteredTodos = state.filteredTodos
        for index in indexSet {
          state.todos.remove(id: filteredTodos[index].id)
        }
        return .none
        
      case var .moveRow(indexSet, destination):
        if state.filter == .completed {
          indexSet = IndexSet(
            indexSet
              .map { state.filteredTodos[$0] }
              .compactMap { state.todos.index(id: $0.id) }
          )
          destination = (
            destination < state.filteredTodos.endIndex ?
              state.todos.index(id: state.filteredTodos[destination].id)
              : state.todos.endIndex
          ) ?? destination
        }
        state.todos.move(fromOffsets: indexSet, toOffset: destination)
        return .run { send in
          try await clock.sleep(for: .milliseconds(100))
          await send(.sortCompletedTodos)
        }
        
      case .didTapClearCompleteButton:
        state.todos.removeAll(where: \.isComplete)
        return .none
        
      case .didTapAddTodoButton:
        state.todos.insert(TodoCore.State(id: uuid()), at: 0)
        return .none
        
      case .todoRowAction(id: _, action: .binding(\.$isComplete)):
        return .run { send in
          try await clock.sleep(for: .seconds(1))
          await send(.sortCompletedTodos, animation: .default)
        }
        .cancellable(id: CancelID.todoCompletion, cancelInFlight: true)
        
      case .todoRowAction:
        return .none
        
      case .sortCompletedTodos:
        state.todos.sort { $1.isComplete && ($0.isComplete == false) }
        return .none
      }
    }
    .forEach(\.todos, action: /Action.todoRowAction) {
      TodoCore()
    }
  }
}

struct AppView: View {
  private let store: StoreOf<AppCore>
  @ObservedObject private var viewStore: ViewStore<AppView.ViewState, AppCore.Action>
  
  struct ViewState: Equatable {
    @BindingViewState var editMode: EditMode
    @BindingViewState var filter: Filter
    let isClearButtonDisabled: Bool
    
    init(store: BindingViewStore<AppCore.State>) {
      self._editMode = store.$editMode
      self._filter = store.$filter
      self.isClearButtonDisabled = store.todos.contains(where: \.isComplete) == false
    }
  }
  
  init() {
    self.store = .init(initialState: AppCore.State(todos: .mock)) {
      AppCore()
    }
    self.viewStore = .init(store, observe: ViewState.init)
  }
  
  var body: some View {
    NavigationStack {
      VStack(alignment: .leading) {
        Picker("Filter", selection: viewStore.$filter.animation()) {
          ForEach(Filter.allCases, id: \.self) {
            Text($0.rawValue).tag($0)
          }
        }
        .pickerStyle(.segmented)
        .padding(.horizontal)
        
        List {
          ForEachStore(store.scope(
            state: \.filteredTodos,
            action: { .todoRowAction(id: $0, action: $1) }
          )) {
            TodoView(store: $0)
          }
          .onDelete { store.send(.deleteRow($0)) }
          .onMove { store.send(.moveRow($0, $1)) }
        }
      }
      .navigationTitle("Todos")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          HStack(spacing: 20) {
            EditButton()
            Button("Clear Completed") {
              store.send(.didTapClearCompleteButton, animation: .default)
            }
            .disabled(viewStore.isClearButtonDisabled)
            Button("Add Todo") {
              store.send(.didTapAddTodoButton, animation: .default)
            }
          }
        }
      }
      .environment(\.editMode, viewStore.$editMode)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    AppView()
      .previewLayout(.sizeThatFits)
  }
}

extension IdentifiedArray where ID == TodoCore.State.ID, Element == TodoCore.State {
  static let mock: Self = [
    TodoCore.State(
      id: UUID(),
      description: "Check Mail",
      isComplete: false
    ),
    TodoCore.State(
      id: UUID(),
      description: "Buy Milk",
      isComplete: false
    ),
    TodoCore.State(
      id: UUID(),
      description: "Call Mom",
      isComplete: false
    )
  ]
}
