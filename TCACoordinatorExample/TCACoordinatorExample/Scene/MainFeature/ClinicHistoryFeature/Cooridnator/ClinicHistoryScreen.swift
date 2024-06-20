//
//  ClinicHistoryScreen.swift
//  TCACoordinatorExample
//
//  Created by LS-NOTE-00106 on 6/20/24.
//

import Foundation

import ComposableArchitecture

@Reducer
struct ClinicHistoryScreen {
  enum State: Equatable, Identifiable {
    case selectDepartment(SelectDepartmentCore.State)
    case selectDoctor(SelectDoctorCore.State)
    
    var id: UUID {
      switch self {
      case let .selectDepartment(state):
        return state.id
      case let .selectDoctor(state):
        return state.id
      }
    }
  }
  
  enum Action: Equatable {
    case selectDepartment(SelectDepartmentCore.Action)
    case selectDoctor(SelectDoctorCore.Action)
  }
  
  var body: some ReducerOf<Self> {
    Scope(state: /State.selectDepartment, action: /Action.selectDepartment) {
      SelectDepartmentCore()
    }
    Scope(state: /State.selectDoctor, action: /Action.selectDoctor) {
      SelectDoctorCore()
    }
  }
}
