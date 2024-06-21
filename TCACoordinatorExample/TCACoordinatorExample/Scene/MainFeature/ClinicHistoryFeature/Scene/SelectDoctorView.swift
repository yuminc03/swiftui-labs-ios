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
    case tapGotoPrescriptionTab
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .tapPopButton:
        break
        
      case .tapGotoPrescriptionTab:
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
      Text("SelectDoctor")
      BasicButton(title: "Pop") {
        store.send(.tapPopButton)
      }
      BasicButton(title: "go to Prescription Tab") {
        store.send(.tapGotoPrescriptionTab)
      }
    }
    .onAppear {
      print("🩵 SelectDoctor onAppear")
      NotiService.post(name: .hideTab)
    }
    .onDisappear {
      print("🩶 SelectDoctor onDisappear")
    }
  }
}

#Preview {
  SelectDoctorView(store: .init(initialState: SelectDoctorCore.State()) {
    SelectDoctorCore()
  })
}
