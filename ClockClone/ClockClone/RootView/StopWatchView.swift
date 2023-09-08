//
//  StopWatchView.swift
//  ClockClone
//
//  Created by Yumin Chu on 2023/09/03.
//

import SwiftUI

import ComposableArchitecture

struct StopWatchCore: Reducer { // rap 기능, state 변수 개수 줄이기 (숫자 너비 고려하기)
  struct State: Equatable {
    // timer는 하나로 충분함, currentTime 하나로 타이머 시간 계산, rapTime 저장, buttonState enum을 정의해서 사용
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
      if state.isStartButton == false {
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
      state.millisecondText = String(format: "%02d", state.stopWatchMilliSecond % 100)
      
      guard state.stopWatchMilliSecond / 100 > 0 else { return .none }
      state.stopWatchSecond = state.stopWatchMilliSecond / 100
      state.secondText = String(format: "%02d", state.stopWatchSecond % 60)
      
      guard state.stopWatchSecond / 60 > 0 else { return .none }
      state.stopWatchMinute = state.stopWatchSecond / 60
      state.minuteText = String(format: "%02d", state.stopWatchMinute % 60)
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
      state.rapMilliText = String(format: "%02d", state.rapMilliSecond % 100)
      
      guard state.rapMilliSecond / 100 > 0 else { return .none }
      state.rapSecond = state.stopWatchMilliSecond / 100
      state.rapSecondText = String(format: "%02d", state.rapSecond % 60)
      
      guard state.rapSecond / 60 > 0 else { return .none }
      state.rapMinute = state.rapSecond / 60
      state.rapMinuteText = String(format: "%02d", state.rapMinute % 60)
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
      ZStack(alignment: .bottom) {
        // view 깔끔하게 수정 (알아보기 쉽도록) - 큰 컴포넌트 이름으로 보여주기 - 쓸모없는 코드 삭제
        tabView
        buttons
        .padding(.bottom, 10)
      }
      Divider()
        .background(.gray)
      rapList
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
      Text(viewStore.minuteText) // 시간 다시 표현(format)
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
      ForEach(0 ..< viewStore.raps.count, id: \.self) { index in
        StopWatchRow( // index == 0일 때만 숫자가 계속 올라감(타이머)
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
