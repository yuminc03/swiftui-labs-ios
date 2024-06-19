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
    
  }
  
  enum Action: Equatable {
    
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      return .none
    }
  }
}

struct AppView: View {
  private let store: StoreOf<AppCore>
  @ObservedObject private var viewStore: ViewStoreOf<AppCore>
  
  init(store: StoreOf<AppCore>) {
    self.store = store
    self.viewStore = .init(self.store, observe: { $0 })
  }
  
  var body: some View {
    Text("")
  }
}

#Preview {
  AppView(store: .init(initialState: AppCore.State()) {
    AppCore()
  })
}
