//
//  ClinicHistoryCoordinator.swift
//  TCACoordinatorExample
//
//  Created by LS-NOTE-00106 on 6/20/24.
//

import SwiftUI

import ComposableArchitecture
import TCACoordinators

@Reducer
struct ClinicHistoryCoordinator {
  struct State: Equatable, IdentifiedRouterState {
    static let initialState = State(routes: [.root(.selectDepartment(.init()), embedInNavigationView: true)])
    
    var routes: IdentifiedArrayOf<Route<ClinicHistoryScreen.State>>
  }
  
  enum Action: Equatable, IdentifiedRouterAction {
    case routeAction(ClinicHistoryScreen.State.ID, action: ClinicHistoryScreen.Action)
    case updateRoutes(IdentifiedArrayOf<Route<ClinicHistoryScreen.State>>)
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .routeAction(_, action: .selectDepartment(.tapPushButton)):
        state.routes.push(.selectDoctor(.init()))
        
      case .routeAction(_, action: .selectDoctor(.tapPopButton)):
        state.routes.pop()
        
        default: break
      }
      
      return .none
    }
    .forEachRoute {
      ClinicHistoryScreen()
    }
  }
}

struct ClinicHistoryCoordinatorView: View {
  let store: StoreOf<ClinicHistoryCoordinator>
  
  var body: some View {
    TCARouter(store) { screen in
      SwitchStore(screen) { screen in
        switch screen {
        case .selectDepartment:
          CaseLet(
            /ClinicHistoryScreen.State.selectDepartment, 
             action: ClinicHistoryScreen.Action.selectDepartment,
             then: SelectDepartmentView.init
          )
          
        case .selectDoctor:
          CaseLet(
            /ClinicHistoryScreen.State.selectDoctor,
             action: ClinicHistoryScreen.Action.selectDoctor,
             then: SelectDoctorView.init
          )
        }
      }
    }
  }
}
