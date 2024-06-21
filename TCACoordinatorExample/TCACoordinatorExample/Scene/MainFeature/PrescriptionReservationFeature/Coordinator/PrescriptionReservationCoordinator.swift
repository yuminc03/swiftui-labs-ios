//
//  PrescriptionReservationCoordinator.swift
//  TCACoordinatorExample
//
//  Created by LS-NOTE-00106 on 6/20/24.
//

import SwiftUI

import ComposableArchitecture
import TCACoordinators

@Reducer
struct PrescriptionReservationCoordinator {
  struct State: Equatable, IdentifiedRouterState {
    static let initialState = State(routes: [.root(.selectDelivery(.init()), embedInNavigationView: true)])
    
    var routes: IdentifiedArrayOf<Route<PrescriptionReservationScreen.State>>
  }
  
  enum Action: Equatable, IdentifiedRouterAction {
    case routeAction(PrescriptionReservationScreen.State.ID, action: PrescriptionReservationScreen.Action)
    case updateRoutes(IdentifiedArrayOf<Route<PrescriptionReservationScreen.State>>)
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .routeAction(_, action: .selectDelivery(.tapPushButton)):
        state.routes.push(.searchPharmacy(.init()))
        
      case .routeAction(_, action: .searchPharmacy(.tapPopButton)):
        state.routes.pop()
        
        default: break
      }
      
      return .none
    }
    .forEachRoute {
      PrescriptionReservationScreen()
    }
  }
}

struct PrescriptionReservationCoordinatorView: View {
  let store: StoreOf<PrescriptionReservationCoordinator>
  
  var body: some View {
    TCARouter(store) { screen in
      SwitchStore(screen) { screen in
        switch screen {
        case .selectDelivery:
          CaseLet(
            /PrescriptionReservationScreen.State.selectDelivery,
             action: PrescriptionReservationScreen.Action.selectDelivery,
             then: SelectPrescriptionDeliveryView.init
          )
          
        case .searchPharmacy:
          CaseLet(
            /PrescriptionReservationScreen.State.searchPharmacy,
             action: PrescriptionReservationScreen.Action.searchPharmacy,
             then: SearchPharmacyView.init
          )
        }
      }
    }
  }
}
