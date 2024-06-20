//
//  PrescriptionReservationScreen.swift
//  TCACoordinatorExample
//
//  Created by LS-NOTE-00106 on 6/20/24.
//

import SwiftUI

import ComposableArchitecture
import TCACoordinators

@Reducer
struct PrescriptionReservationScreen {
  enum State: Equatable, Identifiable {
    case selectDelivery(SelectPrescriptionDeliveryCore.State)
    case searchPharmacy(SearchPharmacyCore.State)
    
    var id: UUID {
      switch self {
      case let .selectDelivery(state):
        return state.id
      case let .searchPharmacy(state):
        return state.id
      }
    }
  }
  
  enum Action: Equatable {
    case selectDelivery(SelectPrescriptionDeliveryCore.Action)
    case searchPharmacy(SearchPharmacyCore.Action)
  }
  
  var body: some ReducerOf<Self> {
    Scope(state: /State.selectDelivery, action: /Action.selectDelivery) {
      SelectPrescriptionDeliveryCore()
    }
    Scope(state: /State.searchPharmacy, action: /Action.searchPharmacy) {
      SearchPharmacyCore()
    }
  }
}
