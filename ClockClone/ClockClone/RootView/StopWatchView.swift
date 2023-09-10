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
    var currentTime = 0
    var rapTime = 0
    var buttonState: ButtonState = .start
    var rapButtonState: RapButtonState = .rap
    var raps = [Int]()
  }
  
  enum Action {
    case didTapRapButton
    case didToggleStartButton
    case stopWatchTicked
    case stopWatchAction
    case didCancelStopWatch
  }
  
  @Dependency(\.continuousClock) var stopWatchClock

  private enum CancelID {
    case stopWatch
  }
  
  enum ButtonState: Equatable {
    case start
    case stop
    
    var title: String {
      switch self {
      case .start:
        return "시작"
        
      case .stop:
        return "중단"
      }
    }
      
    var bgColor: StopWatchButtonType {
      switch self {
      case .start:
        return .green
        
      case .stop:
        return .red
      }
    }
  }
  
  enum RapButtonState: Equatable {
    case rap
    case reset
    
    var title: String {
      switch self {
      case .rap:
        return "랩"
        
      case .reset:
        return "재설정"
      }
    }
      
    var bgColor: StopWatchButtonType {
      switch self {
      case .rap:
        return .gray
        
      case .reset:
        return .gray
      }
    }
  }
    
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case .didTapRapButton:
      switch state.rapButtonState {
      case .rap:
        state.raps.insert(state.rapTime, at: 0)
        state.raps[1] = state.rapTime
        state.rapTime = 0
        return .none
        
      case .reset:
        state.buttonState = .start
        state.rapButtonState = .rap
        state.currentTime = 0
        state.rapTime = 0
        state.raps = []
        return .none
      }
      
    case .didToggleStartButton:
      switch state.buttonState {
      case .start:
        state.rapButtonState = .rap
        state.buttonState = .stop
        state.raps.insert(state.rapTime, at: 0)
        return .run { send in
          await send(.stopWatchAction)
        }
        
      case .stop:
        state.rapButtonState = .reset
        state.buttonState = .start
        return .run { send in
          await send(.stopWatchAction)
        }
      }
      
    case .stopWatchAction:
      return .run { [buttonState = state.buttonState] send in
        guard buttonState == .stop else { return }
        for await _ in stopWatchClock.timer(interval: .seconds(0.01)) {
          await send(.stopWatchTicked)
        }
      }
      .cancellable(id: CancelID.stopWatch, cancelInFlight: true)
      
    case .stopWatchTicked:
      state.currentTime += 1
      state.rapTime += 1
      return .none
      
    case .didCancelStopWatch:
      return .cancel(id: CancelID.stopWatch)
    }
  }
}

struct StopWatchView: View {
  private let store: StoreOf<StopWatchCore>
  @ObservedObject private var viewStore: ViewStoreOf<StopWatchCore>
  
  init() {
    self.store = .init(initialState: .init()) {
      StopWatchCore()
        ._printChanges()
    }
    self.viewStore = .init(store, observe: { $0 })
  }
  
  var body: some View {
    VStack {
      ZStack(alignment: .bottom) {
        tabView
        buttons
      }
      divider
      rapList
    }
    .padding(.horizontal, 20)
    .onDisappear {
      store.send(.didCancelStopWatch)
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
    .padding(.bottom, 20)
  }
  
  var stopWatchView: some View {
    Text(convertToText(currentTime: viewStore.currentTime))
      .monospacedDigit()
      .fontWeight(.thin)
      .font(.system(size: UIScreen.main.bounds.width / 5))
  }
  
  var clockView: some View {
    AnalogClockView(
      seconds: 0,
      minute: 0
    )
  }
  
  var divider: some View {
    Divider()
      .background(.gray)
  }
  
  var buttons: some View {
    HStack(spacing: 0) {
      StopWatchButton(
        title: viewStore.rapButtonState.title,
        type: viewStore.rapButtonState.bgColor
      ) {
        store.send(.didTapRapButton)
      }
      Spacer()
      StopWatchButton(
        title: viewStore.buttonState.title,
        type: viewStore.buttonState.bgColor
      ) {
        store.send(.didToggleStartButton)
      }
    }
    .padding(.bottom, 10)
  }
  
  var rapList: some View {
    List {
      ForEach(0 ..< viewStore.raps.count, id: \.self) { index in
        StopWatchRow(
          labTime: LabTimeItem(
            id: viewStore.raps.count - index,
            savedTime: index == 0 ? convertToText(currentTime: viewStore.rapTime)
            : convertToText(currentTime: viewStore.raps[index])
          ),
          colorType: .white
        )
      }
      .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
    .listStyle(.plain)
    .frame(height: UIScreen.main.bounds.height / 3)
  }
  
  private func convertToText(currentTime: Int) -> String {
    let milliSeconds = currentTime % 100
    let seconds = currentTime / 100 % 60
    let minute = currentTime / 100 % 60 / 60
    return String(format: "%02d:%02d:%02d", minute, seconds, milliSeconds)
  }
}
