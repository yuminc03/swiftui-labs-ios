//
//  MainTabCoordinator.swift
//  TCACoordinatorExample
//
//  Created by LS-NOTE-00106 on 6/20/24.
//

import SwiftUI

import ComposableArchitecture
import TCACoordinators

@Reducer
struct MainTabCoordinator {
  struct State: Equatable {
    static let initialState = State(
      home: .initialState,
      clinicList: .initialState,
      prescription: .initialState,
      tab: .home
    )
    var home: HomeCoordinator.State
    var clinicList: ClinicHistoryCoordinator.State
    var prescription: PrescriptionReservationCoordinator.State
    
    var tab: Tab = .home
  }
  
  enum Action: Equatable {
    case home(HomeCoordinator.Action)
    case clinicList(ClinicHistoryCoordinator.Action)
    case prescription(PrescriptionReservationCoordinator.Action)
    
    case setTab(to: Tab)
  }
  
  var body: some ReducerOf<Self> {
    Scope(state: \.home, action: /Action.home) {
      HomeCoordinator()
    }
    Scope(state: \.clinicList, action: /Action.clinicList) {
      ClinicHistoryCoordinator()
    }
    Scope(state: \.prescription, action: /Action.prescription) {
      PrescriptionReservationCoordinator()
    }
    Reduce { state, action in
      switch action {
      case let .setTab(to: tab):
        state.tab = tab
        switch tab {
        case .home:
          state.home = .initialState
          
        case .clinicList:
          state.clinicList = .initialState
          
        case .prescription:
          state.prescription = .initialState
        }
        
      case .home(.routeAction(_, action: .home(.tapGotoClinicTab))):
        state.tab = .clinicList
        
      case .home(.routeAction(_, action: .noticeDetail(.tapGotoClinicTab))):
        state.tab = .clinicList
        
      case .clinicList(.routeAction(_, action: .selectDepartment(.tapGotoPrescriptionTab))):
        state.tab = .prescription
        
      case .clinicList(.routeAction(_, action: .selectDoctor(.tapGotoPrescriptionTab))):
        state.tab = .prescription
        
      case .prescription(.routeAction(_, action: .selectDelivery(.tapGotoHomeTab))):
        state.tab = .home
        
      case .prescription(.routeAction(_, action: .searchPharmacy(.tapGotoHomeTab))):
        state.tab = .home
        
      default: break
      }
      
      return .none
    }
  }
}

struct MainTabCoordinatorView: View {
  let store: StoreOf<MainTabCoordinator>
  @EnvironmentObject var stateManager: StateManager
  
  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      ZStack(alignment: .bottom) {
        switch viewStore.tab {
        case .home:
          HomeCoordinatorView(store: store.scope(state: \.home, action: \.home))
            .environmentObject(stateManager)
            .tag(Tab.home)
          
        case .clinicList:
          ClinicHistoryCoordinatorView(store: store.scope(state: \.clinicList, action: \.clinicList))
            .environmentObject(stateManager)
            .tag(Tab.clinicList)
          
        case .prescription:
          PrescriptionReservationCoordinatorView(store: store.scope(state: \.prescription, action: \.prescription))
            .environmentObject(stateManager)
            .tag(Tab.prescription)
        }
        
        if stateManager.isTabBarPresented {
          CustomTabBar(index: .init(get: { viewStore.tab }, set: { store.send(.setTab(to: $0)) }))
        }
      }
    }
  }
}


