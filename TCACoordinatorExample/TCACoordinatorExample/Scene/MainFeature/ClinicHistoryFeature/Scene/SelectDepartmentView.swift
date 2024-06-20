//
//  SelectDepartmentView.swift
//  TCACoordinatorExample
//
//  Created by LS-NOTE-00106 on 6/20/24.
//

import SwiftUI

import ComposableArchitecture

struct SelectDepartmentCore: Reducer {
  struct State: Equatable {
    let id = UUID()
  }
  
  enum Action: Equatable {
    case tapPushButton
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .tapPushButton:
        break
      }
      
      return .none
    }
  }
}

struct SelectDepartmentView: View {
  private let store: StoreOf<SelectDepartmentCore>
  @ObservedObject private var viewStore: ViewStoreOf<SelectDepartmentCore>
  
  init(store: StoreOf<SelectDepartmentCore>) {
    self.store = store
    self.viewStore = .init(self.store, observe: { $0 })
  }
  
  var body: some View {
    VStack(spacing: 30) {
      BasicButton(title: "Push") {
        store.send(.tapPushButton)
      }
    }
  }
}

#Preview {
  SelectDepartmentView(store: .init(initialState: SelectDepartmentCore.State()) {
    SelectDepartmentCore()
  })
}
