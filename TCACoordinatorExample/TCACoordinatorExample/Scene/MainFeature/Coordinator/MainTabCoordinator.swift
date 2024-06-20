//
//  MainTabCoordinator.swift
//  TCACoordinatorExample
//
//  Created by LS-NOTE-00106 on 6/20/24.
//

import Foundation
import SwiftUI

import ComposableArchitecture
import TCACoordinators

@Reducer
struct MainTabCoordinator {
  struct State: Equatable {
    
  }
  
  enum Action: Equatable {
    
  }
  
  var body: some ReducerOf<Self> {
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


