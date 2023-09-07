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
    var stopWatchMinute = 0
    var stopWatchSecond = 0
    var stopWatchMilliSecond = 0
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
      state.savedMilliSeconds.append(state.rapMilliSecond)
      state.raps[state.raps.count - 1] = "\(state.rapMinuteText):\(state.rapSecondText).\(state.rapMilliText)"
      state.raps.append("")
      state.stopWatchMilliSecond = 0
      state.stopWatchSecond = 0
      state.stopWatchMinute = 0
      return .run { send in
        await send(.rapAction)
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
      if state.isStartButton {
        state.raps.append("")
      }
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
      state.stopWatchMilliSecond = 0
      state.stopWatchSecond = 0
      state.stopWatchMinute = 0
      state.raps = []
      state.savedMilliSeconds = []
      return .run { send in
        await send(.didCancelStopWatch)
        await send(.didCancelRap)
      }
      
    case .didTapReStartButton:
      state.isTapReStartButton = true
      return .none
      
    case .timerTicked:
      state.stopWatchMilliSecond += 1
      state.millisecondText = calculateMilliSecond(state.stopWatchMilliSecond)
      
      guard state.stopWatchMilliSecond / 100 > 0 else { return .none }
      state.stopWatchSecond = state.stopWatchMilliSecond / 100
      state.secondText = calculateMinuteAndSecond(state.stopWatchSecond)
      
      guard state.stopWatchSecond / 60 > 0 else { return .none }
      state.stopWatchMinute = state.stopWatchSecond / 60
      state.minuteText = calculateMinuteAndSecond(state.stopWatchMinute)
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
      return .run { [isStartButton = state.isStartButton] send in
        guard isStartButton == false else { return }
        for await _ in rapClock.timer(interval: .seconds(0.01)) {
          await send(.rapTimerTicked)
        }
      }
      .cancellable(id: CancelID.rap, cancelInFlight: true)
      
    case .rapTimerTicked:
      state.rapMilliSecond += 1
      state.rapMilliText = calculateMilliSecond(state.rapMilliSecond)
      
      guard state.rapMilliSecond / 100 > 0 else { return .none }
      state.rapSecond = state.stopWatchMilliSecond / 100
      state.rapSecondText = calculateMinuteAndSecond(state.rapSecond)
      
      guard state.rapSecond / 60 > 0 else { return .none }
      state.rapMinute = state.rapSecond / 60
      state.rapMinuteText = calculateMinuteAndSecond(state.rapMinute)
      return .none
      
    case .didCancelStopWatch:
      return .cancel(id: CancelID.stopWatch)
      
    case .didCancelRap:
      return .cancel(id: CancelID.rap)
    }
  }
  
  private func calculateMinuteAndSecond(_ second: Int) -> String {
    if Int(second % 60) < 10 {
      return "0\(Int(second % 60))"
    } else {
      return "\(Int(second % 60))"
    }
  }
  
  private func calculateMilliSecond(_ milliSecond: Int) -> String {
    if Int(milliSecond % 100) < 10 {
      return "0\(Int(milliSecond % 100))"
    } else {
      return "\(Int(milliSecond % 100))"
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
          buttons
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
        rapList
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
      seconds: viewStore.stopWatchSecond,
      minute: viewStore.stopWatchMinute
    )
  }
  
  var buttons: some View {
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
          store.send(.rapTimerStart)
        }
      }
    }
  }
  
  var rapList: some View {
    List {
      ForEach(0 ..< viewStore.raps.count) { index in
        StopWatchRow(
          labTime: LabTimeItem(
            id: index + 1,
            savedTime: index == 0 ?
            "\(viewStore.rapMinuteText):\(viewStore.rapSecondText).\(viewStore.rapMilliText)"
            : viewStore.raps[index]
          ),
          colorType: .white
        )
      }
      .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
    .listStyle(.plain)
    .frame(height: UIScreen.main.bounds.height / 3)
  }
}
