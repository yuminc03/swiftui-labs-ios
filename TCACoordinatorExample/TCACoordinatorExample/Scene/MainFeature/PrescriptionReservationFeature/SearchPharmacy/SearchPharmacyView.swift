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
    
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
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
    Text("")
  }
}

#Preview {
  SearchPharmacyView(store: .init(initialState: SearchPharmacyCore.State()) {
    SearchPharmacyCore()
  })
}
