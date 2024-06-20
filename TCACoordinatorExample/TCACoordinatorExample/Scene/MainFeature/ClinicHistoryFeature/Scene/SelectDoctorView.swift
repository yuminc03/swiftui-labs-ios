//
//  SelectDoctorView.swift
//  TCACoordinatorExample
//
//  Created by LS-NOTE-00106 on 6/20/24.
//

import SwiftUI

import ComposableArchitecture

struct SelectDoctorCore: Reducer {
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

struct SelectDoctorView: View {
  private let store: StoreOf<SelectDoctorCore>
  @ObservedObject private var viewStore: ViewStoreOf<SelectDoctorCore>
  
  init(store: StoreOf<SelectDoctorCore>) {
    self.store = store
    self.viewStore = .init(self.store, observe: { $0 })
  }
  
  var body: some View {
    Text("")
  }
}

#Preview {
  SelectDoctorView(store: .init(initialState: SelectDoctorCore.State()) {
    SelectDoctorCore()
  })
}
