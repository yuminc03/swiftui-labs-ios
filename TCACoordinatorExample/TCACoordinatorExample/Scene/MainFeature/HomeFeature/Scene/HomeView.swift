//
//  HomeView.swift
//  TCACoordinatorExample
//
//  Created by LS-NOTE-00106 on 6/20/24.
//

import SwiftUI

import ComposableArchitecture

@Reducer
struct HomeCore: Reducer {
  struct State: Equatable {
    let id = UUID()
  }
  
  enum Action: Equatable {
    case tapPushScreenButton
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      return .none
    }
  }
}

struct HomeView: View {
  private let store: StoreOf<HomeCore>
  @ObservedObject private var viewStore: ViewStoreOf<HomeCore>
  
  init(store: StoreOf<HomeCore>) {
    self.store = store
    self.viewStore = .init(self.store, observe: { $0 })
  }

  var body: some View {
    Button {
      store.send(.tapPushScreenButton)
    } label: {
      Text("Push Screen")
        .foregroundColor(.white)
        .padding()
        .background(.blue)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
  }
}

#Preview {
  HomeView(store: .init(initialState: HomeCore.State()) {
    HomeCore()
  })
}
