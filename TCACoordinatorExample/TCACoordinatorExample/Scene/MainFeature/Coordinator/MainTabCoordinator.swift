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
    var home: HomeCoordinator.State
    var clinicList: ClinicHistoryCoordinator.State
    var prescription: PrescriptionReservationCoordinator.State
  }
  
  enum Action: Equatable {
    case home(HomeCoordinator.Action)
    case clinicList(ClinicHistoryCoordinator.Action)
    case prescription(PrescriptionReservationCoordinator.Action)
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
      default: break
      }
      
      return .none
    }
  }
}

struct MainTabCoordinatorView: View {
  private let store: StoreOf<MainTabCoordinator>
  
  init(store: StoreOf<MainTabCoordinator>) {
    self.store = store
  }
  
  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      ZStack(alignment: .bottom) {
        
      }
    }
  }
}


