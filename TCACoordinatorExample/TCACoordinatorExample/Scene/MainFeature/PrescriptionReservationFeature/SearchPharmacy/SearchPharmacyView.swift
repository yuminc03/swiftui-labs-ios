//
//  SearchPharmacyView.swift
//  TCACoordinatorExample
//
//  Created by LS-NOTE-00106 on 6/20/24.
//

import SwiftUI

import ComposableArchitecture

struct SearchPharmacyCore: Reducer {
  struct State: Equatable {
    let id = UUID()
  }
  
  enum Action: Equatable {
    case tapPopButton
    case tapGotoHomeTab
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .tapPopButton:
        break
        
      case .tapGotoHomeTab:
        break
      }
      
      return .none
    }
  }
}

struct SearchPharmacyView: View {
  private let store: StoreOf<SearchPharmacyCore>
  @ObservedObject private var viewStore: ViewStoreOf<SearchPharmacyCore>
  
  init(store: StoreOf<SearchPharmacyCore>) {
    self.store = store
    self.viewStore = .init(self.store, observe: { $0 })
  }
  
  var body: some View {
    VStack(spacing: 30) {
      BasicButton(title: "Pop") {
        store.send(.tapPopButton)
      }
      BasicButton(title: "go to Home Tab") {
        store.send(.tapGotoHomeTab)
      }
    }
  }
}

#Preview {
  SearchPharmacyView(store: .init(initialState: SearchPharmacyCore.State()) {
    SearchPharmacyCore()
  })
}
