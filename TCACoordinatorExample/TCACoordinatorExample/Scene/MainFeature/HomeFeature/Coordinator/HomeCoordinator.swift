//
//  HomeCoordinator.swift
//  TCACoordinatorExample
//
//  Created by LS-NOTE-00106 on 6/20/24.
//

import SwiftUI

import ComposableArchitecture
import TCACoordinators

@Reducer
struct HomeCoordinator {
  struct State: Equatable, IdentifiedRouterState {
    static let initialState = State(routes: [.root(.home(.init()), withNavigation: true)])
    
    var routes: IdentifiedArrayOf<Route<HomeScreen.State>>
  }
  
  enum Action: Equatable, IdentifiedRouterAction {
    case routeAction(HomeScreen.State.ID, action: HomeScreen.Action)
    case updateRoutes(IdentifiedArrayOf<Route<HomeScreen.State>>)
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
        default: break
      }
      
      return .none
    }
    .forEachRoute {
      HomeScreen()
    }
  }
}

struct HomeCoordinatorView: View {
  let store: StoreOf<HomeCoordinator>
  
  var body: some View {
    TCARouter(store) { screen in
      SwitchStore(screen) { screen in
        switch screen {
        case .home:
          CaseLet(
            /HomeScreen.State.home,
             action: HomeScreen.Action.home,
             then: HomeView.init
          )
          
        case .selectPrescriptionDelivery:
          CaseLet(
            /HomeScreen.State.selectPrescriptionDelivery,
             action: HomeScreen.Action.selectPrescriptionDelivery,
             then: SelectPrescriptionDeliveryView.init
          )
        }
      }
    }
  }
}
