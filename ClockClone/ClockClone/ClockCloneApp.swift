//
//  ClockCloneApp.swift
//  ClockClone
//
//  Created by Yumin Chu on 2023/09/03.
//

import SwiftUI

import ComposableArchitecture

@main
struct ClockCloneApp: App {
  
  private let store: StoreOf<WorldClockCore>
  @ObservedObject var viewStore: ViewStoreOf<WorldClockCore>
  
  init() {
    self.store = Store(initialState: WorldClockCore.State()) {
      WorldClockCore()
        ._printChanges()
    }
    self.viewStore = ViewStore(store, observe: { $0 })
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
