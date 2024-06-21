//
//  SelectPrescriptionDeliveryView.swift
//  TCACoordinatorExample
//
//  Created by LS-NOTE-00106 on 6/20/24.
//

import SwiftUI

import ComposableArchitecture

struct SelectPrescriptionDeliveryCore: Reducer {
  struct State: Equatable {
    let id = UUID()
  }
  
  enum Action: Equatable {
    case tapPushButton
    case tapGotoHomeTab
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .tapPushButton:
        break
        
      case .tapGotoHomeTab:
        break
      }
      
      return .none
    }
  }
}

struct SelectPrescriptionDeliveryView: View {
  private let store: StoreOf<SelectPrescriptionDeliveryCore>
  @ObservedObject private var viewStore: ViewStoreOf<SelectPrescriptionDeliveryCore>
  
  init(store: StoreOf<SelectPrescriptionDeliveryCore>) {
    self.store = store
    self.viewStore = .init(self.store, observe: { $0 })
  }
  
  var body: some View {
    VStack(spacing: 30) {
      Text("SelectPrescriptionDelivery")
      BasicButton(title: "Push") {
        store.send(.tapPushButton)
      }
      BasicButton(title: "go to Home Tab") {
        store.send(.tapGotoHomeTab)
      }
    }
    .onAppear {
      print("🩵 SelectPrescription onAppear")
      NotiService.post(name: .showTab)
    }
    .onDisappear {
      print("🩶 SelectPrescription onDisappear")
    }
  }
}

#Preview {
  SelectPrescriptionDeliveryView(store: .init(initialState: SelectPrescriptionDeliveryCore.State()) {
    SelectPrescriptionDeliveryCore()
  })
}
