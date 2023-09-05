//
//  StopWatchView.swift
//  ClockClone
//
//  Created by Yumin Chu on 2023/09/03.
//

import SwiftUI

import ComposableArchitecture

struct StopWatchCore: Reducer {
  struct State: Equatable {
    var minuteText = "00"
    var secondText = "00"
    var millisecondText = "00"
    var isStartButton = true
    var isTapStartButton = false
    var isTapStopButton = false
    var isTapReStartButton = false
    var timerMinutes = 0
    var timerSeconds = 0
    var timerMilliSeconds = 0
  }
  
  enum Action {
    case didTapRapButton
    case didTapToggleStartButton
    case didTapResetButton
    case didTapReStartButton
    case timerTicked
    case onDisappear
  }
  
  private enum CancelID {
    case timer
  }
  
  @Dependency(\.continuousClock) var clock
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case .didTapRapButton:
      return .none
      
    case .didTapToggleStartButton:
      if state.isStartButton {
        state.isTapStartButton = true
        state.isTapReStartButton = true
      } else {
        state.isTapStopButton = true
        state.isTapReStartButton = false
      }
      state.isStartButton.toggle()
      return .run { [isStartButton = state.isStartButton] send in
        guard isStartButton == false else { return }
        for await _ in clock.timer(interval: .seconds(0.01)) {
          await send(.timerTicked)
        }
      }
      .cancellable(id: CancelID.timer, cancelInFlight: true)
      
    case .didTapResetButton:
      state.minuteText = "00"
      state.secondText = "00"
      state.millisecondText = "00"
      state.isStartButton = true
      state.isTapStartButton = false
      state.isTapStopButton = false
      state.isTapReStartButton = false
      state.timerMilliSeconds = 0
      state.timerSeconds = 0
      state.timerMinutes = 0
      return .cancel(id: CancelID.timer)
      
    case .didTapReStartButton:
      state.isTapReStartButton = true
      return .none
      
    case .timerTicked:
      state.timerMilliSeconds += 1
      if Int(state.timerMilliSeconds % 100) < 10 {
        state.millisecondText = "0\(Int(state.timerMilliSeconds % 100))"
      } else {
        state.millisecondText = "\(Int(state.timerMilliSeconds % 100))"
      }
      
      guard state.timerMilliSeconds / 100 > 0 else { return .none }
      
      state.timerSeconds = state.timerMilliSeconds / 100
      if Int(state.timerSeconds % 60) < 10 {
        state.secondText = "0\(Int(state.timerSeconds % 60))"
      } else {
        state.secondText = "\(Int(state.timerSeconds % 60))"
      }

      guard state.timerSeconds / 60 > 0 else { return .none }

      state.timerMinutes = state.timerSeconds / 60
      if Int(state.timerMinutes % 60) < 10 {
        state.minuteText = "0\(Int(state.timerMinutes % 60))"
      } else {
        state.minuteText = "\(Int(state.timerMinutes % 60))"
      }

      return .none
      
    case .onDisappear:
      return .cancel(id: CancelID.timer)
    }
  }
}

struct StopWatchView: View {
  private let store: StoreOf<StopWatchCore>
  @ObservedObject private var viewStore: ViewStoreOf<StopWatchCore>
  
  init() {
    self.store = .init(initialState: .init()) {
      StopWatchCore()
    }
    self.viewStore = .init(store, observe: { $0 })
  }
  
  var body: some View {
    VStack(spacing: 0) {
      ZStack {
        VStack(alignment: .center, spacing: 20) {
          tabView
          Spacer()
        }
        VStack(spacing: 0) {
          Spacer()
          HStack(spacing: 0) {
            if viewStore.isTapReStartButton {
              stopWatchButton(
                title: "랩",
                type: viewStore.isTapStartButton ?.gray : .darkGray
              ) {
                store.send(.didTapRapButton)
              }
            } else if viewStore.isTapStopButton {
              stopWatchButton(
                title: "재설정",
                type: viewStore.isTapStartButton ?.gray : .darkGray
              ) {
                store.send(.didTapResetButton)
              }
            } else {
              stopWatchButton(
                title: "랩",
                type: viewStore.isTapStartButton ?.gray : .darkGray
              ) {
                store.send(.didTapRapButton)
              }
            }
            Spacer()
            if viewStore.isStartButton {
              stopWatchButton(title: "시작", type: .green) {
                store.send(.didTapToggleStartButton)
              }
            } else {
              stopWatchButton(title: "중단", type: .red) {
                store.send(.didTapToggleStartButton)
              }
            }
          }
        }
        .padding(.bottom, 10)
      }
      List {
        Divider()
          .background(.gray)
          .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
          .listRowSeparator(.hidden)
      }
      .listStyle(.plain)
      .frame(height: UIScreen.main.bounds.height / 3)
    }
    .padding(.horizontal, 20)
    .onDisappear {
      store.send(.onDisappear)
    }
  }
}

struct StopWatchView_Previews: PreviewProvider {
  static var previews: some View {
    StopWatchView()
      .previewLayout(.sizeThatFits)
  }
}

extension StopWatchView {
  
  var tabView: some View {
    TabView {
      stopWatchView
      clockView
    }
    .foregroundColor(.white)
    .tabViewStyle(.page)
  }
  
  private func stopWatchButton(
    title: String,
    type: StopWatchButtonType,
    action: @escaping () -> Void
  ) -> some View {
    Text(title)
      .font(.body)
      .foregroundColor(type.titleColor)
      .frame(width: 90, height: 90)
      .background {
        ZStack(alignment: .center) {
          Circle()
            .fill(type.buttonColor)
            .frame(width: 90, height: 90)
          Circle()
            .fill(.black)
            .frame(height: 85)
          Circle()
            .fill(type.buttonColor)
            .frame(height: 80)
        }
      }
      .onTapGesture {
        action()
      }
  }
  
  var stopWatchView: some View {
    HStack(alignment: .center, spacing: 0) {
      Text(viewStore.minuteText)
        .frame(width: 110)
      Text(":")
      Text(viewStore.secondText)
        .frame(width: 110)
      Text(".")
      Text(viewStore.millisecondText)
        .frame(width: 110)
    }
    .fontWeight(.thin)
    .font(.system(size: UIScreen.main.bounds.width / 5))
    .frame(maxWidth: .infinity)
  }
  
  var clockView: some View {
    Text("Clock")
  }
}
