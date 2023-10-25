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
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      return .none
    }
    .forEach(\.path, action: /Action.path) {
      Path()
    }
  }
  
  struct Path: Reducer {
    enum State: Codable, Equatable, Hashable {
      case screenA(ScreenACore.State = .init())
    }
    
    enum Action {
      case screenA(ScreenACore.Action)
    }
    
    var body: some ReducerOf<Self> {
      Scope(state: /State.screenA, action: /Action.screenA) {
        ScreenACore()
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
    Form {
      Section {
//        NavigationLink("Go to screen A", state: <#T##P?#>)
        
      }
    }
    .navigationTitle("Root")
  }
}

struct NavigationDemoView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationDemoView()
  }
}
