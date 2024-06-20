//
//  HomeScreen.swift
//  TCACoordinatorExample
//
//  Created by LS-NOTE-00106 on 6/20/24.
//

import Foundation

import ComposableArchitecture

@Reducer
struct HomeScreen {
  enum State: Equatable, Identifiable {
    case home(HomeCore.State)
    case selectPrescriptionDelivery(SelectPrescriptionDeliveryCore.State)
    
    var id: UUID {
      switch self {
      case let .home(state):
        return state.id
      case let .selectPrescriptionDelivery(state):
        return state.id
      }
    }
  }
  
  enum Action: Equatable {
    case home(HomeCore.Action)
    case selectPrescriptionDelivery(SelectPrescriptionDeliveryCore.Action)
  }
  
  var body: some ReducerOf<Self> {
    Scope(state: /State.home, action: /Action.home) {
      HomeCore()
    }
    Scope(state: /State.selectPrescriptionDelivery, action: /Action.selectPrescriptionDelivery) {
      SelectPrescriptionDeliveryCore()
    }
  }
}
