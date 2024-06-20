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
    case tapPopButton
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .tapPopButton:
        break
      }
      
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
    VStack(spacing: 30) {
      BasicButton(title: "Pop") {
        store.send(.tapPopButton)
      }
    }
  }
}

#Preview {
  SelectDoctorView(store: .init(initialState: SelectDoctorCore.State()) {
    SelectDoctorCore()
  })
}
