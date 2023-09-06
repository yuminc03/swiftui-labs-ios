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
    var timerMinute = 0
    var timerSecond = 0
    var timerMilliSecond = 0
    var savedMilliSeconds = [Int]()
    var raps = [String]()
    var rapMilliSecond = 0
    var rapSecond = 0
    var rapMinute = 0
    var rapMilliText = "00"
    var rapSecondText = "00"
    var rapMinuteText = "00"
  }
  
  enum Action {
    case didTapRapButton
    case didTapToggleStartButton
    case rapTimerStart
    case didTapResetButton
    case didTapReStartButton
    case timerTicked
    case stopWatchAction
    case rapAction
    case rapTimerTicked
    case didCancelStopWatch
    case didCancelRap
  }
  
  private enum CancelID {
    case stopWatch
    case rap
  }
  
  @Dependency(\.continuousClock) var stopWatchClock
  @Dependency(\.continuousClock) var rapClock
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case .didTapRapButton:
      guard state.isStartButton == false else { return .none }
      return .run { send in
        await send(.rapTimerStart)
      }
      
    case .didTapToggleStartButton:
      if state.isStartButton {
        state.isTapStartButton = true
        state.isTapReStartButton = true
      } else {
        state.isTapStopButton = true
        state.isTapReStartButton = false
      }
      state.isStartButton.toggle()
      return .run { send in
        await send(.stopWatchAction)
      }
      
    case .rapTimerStart:
      guard state.isStartButton == false else { return .none }
      state.raps.append(
        "\(state.rapMinuteText):\(state.rapSecondText).\(state.rapMilliText)"
      )
      state.savedMilliSeconds.append(state.rapMilliSecond)
      return .run { send in
        await send(.rapAction)
      }
      
    case .didTapResetButton:
      state.minuteText = "00"
      state.secondText = "00"
      state.millisecondText = "00"
      state.isStartButton = true
      state.isTapStartButton = false
      state.isTapStopButton = false
      state.isTapReStartButton = false
      state.timerMilliSecond = 0
      state.timerSecond = 0
      state.timerMinute = 0
      state.raps = []
      state.savedMilliSeconds = []
      return .cancel(id: CancelID.stopWatch)
      
    case .didTapReStartButton:
      state.isTapReStartButton = true
      return .none
      
    case .timerTicked:
      state.timerMilliSecond += 1
      if Int(state.timerMilliSecond % 100) < 10 {
        state.millisecondText = "0\(Int(state.timerMilliSecond % 100))"
      } else {
        state.millisecondText = "\(Int(state.timerMilliSecond % 100))"
      }
      
      guard state.timerMilliSecond / 100 > 0 else { return .none }
      
      state.timerSecond = state.timerMilliSecond / 100
      if Int(state.timerSecond % 60) < 10 {
        state.secondText = "0\(Int(state.timerSecond % 60))"
      } else {
        state.secondText = "\(Int(state.timerSecond % 60))"
      }

      guard state.timerSecond / 60 > 0 else { return .none }

      state.timerMinute = state.timerSecond / 60
      if Int(state.timerMinute % 60) < 10 {
        state.minuteText = "0\(Int(state.timerMinute % 60))"
      } else {
        state.minuteText = "\(Int(state.timerMinute % 60))"
      }
      return .none
      
    case .stopWatchAction:
      return .run { [isStartButton = state.isStartButton] send in
        guard isStartButton == false else { return }
        for await _ in stopWatchClock.timer(interval: .seconds(0.01)) {
          await send(.timerTicked)
        }
      }
      .cancellable(id: CancelID.stopWatch, cancelInFlight: true)
      
    case .rapAction:
      return .run { [state = state] send in
        guard state.isStartButton == false else { return }
        for await _ in rapClock.timer(interval: .seconds(0.01)) {
          await send(.rapTimerTicked)
        }
      }
      .cancellable(id: CancelID.rap, cancelInFlight: true)
      
    case .rapTimerTicked:
      state.rapMilliSecond += 1
      if Int(state.rapMilliSecond % 100) < 10 {
        state.rapMilliText = "0\(Int(state.rapMilliSecond % 100))"
      } else {
        state.rapMilliText = "\(Int(state.rapMilliSecond % 100))"
      }
      
      guard state.rapMilliSecond / 100 > 0 else { return .none }
      
      state.rapSecond = state.timerMilliSecond / 100
      if Int(state.rapSecond % 60) < 10 {
        state.rapSecondText = "0\(Int(state.rapSecond % 60))"
      } else {
        state.rapSecondText = "\(Int(state.rapSecond % 60))"
      }

      guard state.rapSecond / 60 > 0 else { return .none }

      state.rapMinute = state.rapSecond / 60
      if Int(state.rapMinute % 60) < 10 {
        state.rapMinuteText = "0\(Int(state.rapMinute % 60))"
      } else {
        state.rapMinuteText = "\(Int(state.rapMinute % 60))"
      }
      return .none
      
    case .didCancelStopWatch:
      return .cancel(id: CancelID.stopWatch)
      
    case .didCancelRap:
      return .cancel(id: CancelID.rap)
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
              StopWatchButton(
                title: "랩",
                type: viewStore.isTapStartButton ?.gray : .darkGray
              ) {
                store.send(.didTapRapButton)
              }
            } else if viewStore.isTapStopButton {
              StopWatchButton(
                title: "재설정",
                type: viewStore.isTapStartButton ?.gray : .darkGray
              ) {
                store.send(.didTapResetButton)
              }
            } else {
              StopWatchButton(
                title: "랩",
                type: viewStore.isTapStartButton ?.gray : .darkGray
              ) {
                store.send(.didTapRapButton)
              }
            }
            Spacer()
            if viewStore.isStartButton {
              StopWatchButton(title: "시작", type: .green) {
                store.send(.didTapToggleStartButton)
                store.send(.rapTimerStart)
              }
            } else {
              StopWatchButton(title: "중단", type: .red) {
                store.send(.didTapToggleStartButton)
              }
            }
          }
        }
        .padding(.bottom, 10)
      }
      Divider()
        .background(.gray)
      if viewStore.raps.isEmpty {
        Rectangle()
          .fill(.black)
          .frame(height: UIScreen.main.bounds.height / 3)
      } else {
        List {
          ForEach(0 ..< viewStore.raps.count) { index in
            StopWatchRow(
              labTime: LabTimeItem(id: index + 1, savedTime: viewStore.raps[index]),
              colorType: .white
            )
          }
          .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .listStyle(.plain)
        .frame(height: UIScreen.main.bounds.height / 3)
      }
    }
    .padding(.horizontal, 20)
    .onDisappear {
      store.send(.didCancelStopWatch)
      store.send(.didCancelRap)
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
    AnalogClockView(
      seconds: viewStore.timerSecond,
      minute: viewStore.timerMinute
    )
  }
}
