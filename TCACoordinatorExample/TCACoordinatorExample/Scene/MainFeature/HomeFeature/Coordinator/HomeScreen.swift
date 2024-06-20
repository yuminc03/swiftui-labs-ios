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
    case noticeDetail(NoticeDetailCore.State)
    
    var id: UUID {
      switch self {
      case let .home(state):
        return state.id
      case let .noticeDetail(state):
        return state.id
      }
    }
  }
  
  enum Action: Equatable {
    case home(HomeCore.Action)
    case noticeDetail(NoticeDetailCore.Action)
  }
  
  var body: some ReducerOf<Self> {
    Scope(state: /State.home, action: /Action.home) {
      HomeCore()
    }
    Scope(state: /State.noticeDetail, action: /Action.noticeDetail) {
      NoticeDetailCore()
    }
  }
}
