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
    case tapPushButton
    case tapGotoClinicTab
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .tapPushButton:
        break
        
      case .tapGotoClinicTab:
        break
      }
      
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
    VStack(spacing: 30) {
      BasicButton(title: "Push") {
        store.send(.tapPushButton)
      }
      BasicButton(title: "go to Clinic Tab") {
        store.send(.tapGotoClinicTab)
      }
    }
    .onAppear {
      print("🩵 Home onAppear")
      NotiService.post(name: .showTab)
    }
    .onDisappear {
      print("🩶 Home onDisappear")
    }
  }
}

#Preview {
  HomeView(store: .init(initialState: HomeCore.State()) {
    HomeCore()
  })
}
