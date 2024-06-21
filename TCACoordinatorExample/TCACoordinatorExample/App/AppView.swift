//
//  ContentView.swift
//  TCACoordinatorExample
//
//  Created by LS-NOTE-00106 on 6/19/24.
//

import SwiftUI

import ComposableArchitecture

@Reducer
struct AppCore {
  struct State: Equatable {
    static let initialState = State(main: .initialState, appState: .main)
    
    enum AppState {
      case main
    }
    
    var main: MainTabCoordinator.State
    
    var appState: AppState
  }
  
  enum Action: Equatable {
    case main(MainTabCoordinator.Action)
  }
  
  var body: some ReducerOf<Self> {
    Scope(state: \.main, action: \.main) {
      MainTabCoordinator()
    }
    Reduce { state, action in
      return .none
    }
  }
}

struct AppView: View {
  private let store: StoreOf<AppCore>
  @ObservedObject private var viewStore: ViewStoreOf<AppCore>
  @StateObject var stateManager = StateManager()
  
  init(store: StoreOf<AppCore>) {
    self.store = store
    self.viewStore = .init(self.store, observe: { $0 })
  }
  
  var body: some View {
    VStack {
      switch viewStore.appState {
      case .main:
        MainTabCoordinatorView(store: store.scope(state: \.main, action: \.main))
          .environmentObject(stateManager)
      }
    }
  }
}

#Preview {
  AppView(store: .init(initialState: AppCore.State(main: .initialState, appState: .main)) {
    AppCore()
  })
}
