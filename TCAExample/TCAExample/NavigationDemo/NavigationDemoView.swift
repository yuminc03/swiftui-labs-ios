//
//  NavigationDemoView.swift
//  TCAExample
//
//  Created by Yumin Chu on 2023/10/25.
//

import SwiftUI

import ComposableArchitecture

struct NavigationDemoCore: Reducer {
  struct State: Equatable {
    var path = StackState<Path.State>()
  }
  
  enum Action {
    case path(StackAction<Path.State, Path.Action>)
    case didTapGotoABCButton
    case goBackScreen(id: StackElementID)
    case popToRoot
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case let .path(stackAction):
        switch stackAction {
        case .element(id: _, action: .screenB(.didTapScreenAButton)):
          state.path.append(.screenA())
          return .none
          
        case .element(id: _, action: .screenB(.didTapScreenBButton)):
          state.path.append(.screenB())
          return .none
          
        case .element(id: _, action: .screenB(.didTapScreenCButton)):
          state.path.append(.screenC())
          return .none
          
        default:
          return .none
        }
        
      case .didTapGotoABCButton:
        state.path.append(.screenA())
        state.path.append(.screenB())
        state.path.append(.screenC())
        return .none
        
      case let .goBackScreen(id):
        state.path.pop(to: id)
        return .none
        
      case .popToRoot:
        state.path.removeAll()
        return .none
      }
    }
    .forEach(\.path, action: /Action.path) {
      Path()
    }
  }
  
  struct Path: Reducer {
    enum State: Codable, Equatable, Hashable {
      case screenA(ScreenACore.State = .init())
      case screenB(ScreenBCore.State = .init())
      case screenC(ScreenCCore.State = .init())
    }
    
    enum Action {
      case screenA(ScreenACore.Action)
      case screenB(ScreenBCore.Action)
      case screenC(ScreenCCore.Action)
    }
    
    var body: some ReducerOf<Self> {
      Scope(state: /State.screenA, action: /Action.screenA) {
        ScreenACore()
      }
      Scope(state: /State.screenB, action: /Action.screenB) {
        ScreenBCore()
      }
      Scope(state: /State.screenC, action: /Action.screenC) {
        ScreenCCore()
      }
    }
  }
}

struct NavigationDemoView: View {
  private let store: StoreOf<NavigationDemoCore>
  @ObservedObject private var viewStore: ViewStoreOf<NavigationDemoCore>
  
  init() {
    self.store = .init(initialState: NavigationDemoCore.State()) {
      NavigationDemoCore()
    }
    self.viewStore = .init(store, observe: { $0 })
  }
  
  var body: some View {
    NavigationStackStore(store.scope(state: \.path, action: { .path($0) })) {
      Form {
        Section {
          NavigationLink(
            "Go to screen A",
            state: NavigationDemoCore.Path.State.screenA()
          )
          NavigationLink(
            "Go to screen B",
            state: NavigationDemoCore.Path.State.screenB()
          )
          NavigationLink(
            "Go to screen C",
            state: NavigationDemoCore.Path.State.screenC()
          )
        }
        
        Section {
          Button("Go to A -> B -> C") {
            store.send(.didTapGotoABCButton)
          }
        }
      }
      .navigationTitle("Root")
    } destination: {
      switch $0 {
      case .screenA:
        CaseLet(
          /NavigationDemoCore.Path.State.screenA,
           action: NavigationDemoCore.Path.Action.screenA
        ) {
          ScreenAView(store: $0)
        }
        
      case .screenB:
        CaseLet(
          /NavigationDemoCore.Path.State.screenB,
           action: NavigationDemoCore.Path.Action.screenB
        ) {
          ScreenBView(store: $0)
        }
        
      case .screenC:
        CaseLet(
          /NavigationDemoCore.Path.State.screenC,
           action: NavigationDemoCore.Path.Action.screenC
        ) {
          ScreenCView(store: $0)
        }
      }
    }
    .safeAreaInset(edge: .bottom) {
      FloatingMenuView(store: store)
    }
    .navigationTitle("Navigation Stack")
  }
}

struct NavigationDemoView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      NavigationDemoView()
    }
  }
}

struct FloatingMenuView: View {
  private let store: StoreOf<NavigationDemoCore>
  @ObservedObject private var viewStore: ViewStore<FloatingMenuView.ViewState, NavigationDemoCore.Action>
  
  init(store: StoreOf<NavigationDemoCore>) {
    self.store = store
    self.viewStore = .init(store, observe: ViewState.init)
  }
  
  struct ViewState: Equatable {
    struct Screen: Equatable, Identifiable {
      let id: StackElementID
      let name: String
    }
    
    var currentStack: [Screen]
    var total: Int
    
    init(state: NavigationDemoCore.State) {
      self.total = 0
      self.currentStack = []
      for (id, element) in zip(state.path.ids, state.path) {
        switch element {
        case let .screenA(screenAState):
          total += screenAState.count
          currentStack.insert(Screen(id: id, name: "Screen A"), at: 0)
          
        case .screenB:
          currentStack.insert(Screen(id: id, name: "Screen B"), at: 0)
          
        case let .screenC(screenBState):
          total += screenBState.count
          currentStack.insert(Screen(id: id, name: "Screen C"), at: 0)
        }
      }
    }
  }
  
  var body: some View {
    if viewStore.currentStack.count > 0 {
      VStack(alignment: .center) {
        Text("Total count: \(viewStore.total)")
        Button("popup to root") {
          store.send(.popToRoot, animation: .default)
        }
        Menu("Current state") {
          ForEach(viewStore.currentStack) { screen in
            Button("\(String(describing: screen.id))) \(screen.name)") {
              store.send(.goBackScreen(id: screen.id))
            }
            .disabled(screen == viewStore.currentStack.first)
          }
          
          Button("Root") {
            store.send(.popToRoot, animation: .default)
          }
        }
      }
      .padding(20)
      .background(Color(.systemBackground))
      .padding(.bottom, 1)
      .transition(.opacity.animation(.default))
      .clipped()
      .shadow(color: .black.opacity(0.2), radius: 5, y: 5)
    }
  }
}
