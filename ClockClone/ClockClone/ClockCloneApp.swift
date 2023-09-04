//
//  ClockCloneApp.swift
//  ClockClone
//
//  Created by Yumin Chu on 2023/09/03.
//

import SwiftUI

import ComposableArchitecture

struct ClockCloneCore: Reducer {
  struct State: Equatable {
    var selectedTabIndex = 0
  }
  
  enum Action {
    case didTapTabItem
  }
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case .didTapTabItem:
      return .none
    }
  }
}

@main
struct ClockCloneApp: App {
  
  private let store: StoreOf<ClockCloneCore>
  @ObservedObject var viewStore: ViewStoreOf<ClockCloneCore>
  
  init() {
    self.store = Store(initialState: ClockCloneCore.State()) {
      ClockCloneCore()
        ._printChanges()
    }
    self.viewStore = ViewStore(store, observe: { $0 })
    UITabBar.appearance().unselectedItemTintColor = UIColor(named: "gray_C7C7C7")
  }
  
  var body: some Scene {
    WindowGroup {
      tabView
    }
  }
}

extension ClockCloneApp {
  
  var tabView: some View {
    TabView(selection: viewStore.binding(get: \.selectedTabIndex, send: .didTapTabItem)) {
      WorldClockView()
      .tabItem {
        Image(systemName: TabItem.worldClock.imageName)
        Text(TabItem.worldClock.label)
      }
      .tag(0)
      
      AlarmView()
        .tabItem {
          Image(systemName: TabItem.alarm.imageName)
          Text(TabItem.alarm.label)
        }
        .tag(1)
      
      StopWatchView()
        .tabItem {
          Image(systemName: TabItem.stopWatch.imageName)
          Text(TabItem.stopWatch.label)
        }
        .tag(2)
      
      TimerView()
        .tabItem {
          Image(systemName: TabItem.timer.imageName)
          Text(TabItem.timer.label)
        }
        .tag(3)
    }
    .tint(.orange)
  }
}
