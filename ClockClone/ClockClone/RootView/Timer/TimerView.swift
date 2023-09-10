//
//  TimerView.swift
//  ClockClone
//
//  Created by Yumin Chu on 2023/09/03.
//

import SwiftUI

import ComposableArchitecture

struct TimerCore: Reducer {
  struct State: Equatable {
    let pickerItems = [
      (0 ..< 24).map { $0.description },
      (0 ..< 60).map { $0.description },
      (0 ..< 60).map { $0.description }
    ]
    var currentTime = 0
    var fullTime = 0
    var endTimerTime = ""
    var buttonType: ButtonType = .start
    var selectedTimes = [0, 0, 0]
    var selectedSound = "프레스토"
    @PresentationState var editSound: EndTimerAlarmListCore.State?
    var progressValue: CGFloat {
      return CGFloat(currentTime) / (CGFloat(fullTime) / 100)
    }
  }
  
  enum Action {
    case didSelectPickerItems([Int])
    case didTapTimerSoundRow
    case editAlarmSound(PresentationAction<EndTimerAlarmListCore.Action>)
    case didTapStartButton
    case didTapCancelButton
    case timerAction
    case timerTicked
    case onDisappear
  }
  
  @Dependency(\.continuousClock) var timer

  private enum CancelID {
    case timer
  }
  
  enum ButtonType {
    case start
    case pause
    case resume
    
    var buttonTitle: String {
      switch self {
      case .start:
        return "시작"
        
      case .pause:
        return "일시 정지"
        
      case .resume:
        return "재개"
      }
    }
    
    var color: StopWatchButtonType {
      switch self {
      case .start, .resume:
        return .green
        
      case .pause:
        return .orange
      }
    }
  }
    
  var body: some ReducerOf<Self> { // view frame 크기 박는 것은 최대한 자제하기
    Reduce { state, action in
      switch action {
      case let .didSelectPickerItems(indeces):
        state.selectedTimes = indeces
        return .none
        
      case .didTapTimerSoundRow:
        state.editSound = EndTimerAlarmListCore.State()
        return .none
        
      case let .editAlarmSound(.presented(.delegate(.save(sound)))):
        state.selectedSound = sound.name
        return .none
        
      case .editAlarmSound:
        return .none
        
      case .didTapStartButton:
        switch state.buttonType {
        case .start:
          let timerTime = (state.selectedTimes[0] * 3600) + (state.selectedTimes[1] * 60) + state.selectedTimes[2]
          state.currentTime = timerTime
          state.fullTime = timerTime
          state.buttonType = .pause
          
        case .pause:
          state.buttonType = .resume
          
        case .resume:
          state.buttonType = .pause
        }
        return .run { send in
          await send(.timerAction)
        }
        
      case .didTapCancelButton:
        state.buttonType = .start
        state.currentTime = 0
        state.fullTime = 0
        return .cancel(id: CancelID.timer)
        
      case .timerAction:
        return .run { [buttonType = state.buttonType] send in
          guard buttonType != .resume else { return }
          for await _ in timer.timer(interval: .seconds(1)) {
            await send(.timerTicked)
          }
        }
        .cancellable(id: CancelID.timer, cancelInFlight: true)
        
      case .timerTicked:
        guard state.currentTime > 0 else {
          return .run { send in
            await send(.didTapCancelButton)
          }
        }
        state.currentTime -= 1
        let targetTime = Calendar.current.date(
          byAdding: .second,
          value: state.currentTime,
          to: Date(),
          wrappingComponents: false
        ) ?? Date()
        state.endTimerTime = DateFormat.convertTimeToString(
          date: targetTime,
          id: CityTime.korean.rawValue
        )
        return .none
        
      case .onDisappear:
        return .cancel(id: CancelID.timer)
      }
    }
    .ifLet(\.$editSound, action: /Action.editAlarmSound) {
      EndTimerAlarmListCore()
    }
  }
}

struct TimerView: View {
  private let store: StoreOf<TimerCore>
  @ObservedObject var viewStore: ViewStoreOf<TimerCore>
  
  init() {
    self.store = Store(initialState: TimerCore.State()) {
      TimerCore()
        ._printChanges()
    }
    self.viewStore = ViewStore(store, observe: { $0 })
  }
  
  var body: some View {
    VStack(spacing: 20) {
      timerView
      VStack(spacing: 40) {
        timerButtons
        TimerSoundRow(title: "타이머 종료 시", selectedName: viewStore.selectedSound) {
          store.send(.didTapTimerSoundRow)
        }
      }
      Spacer(minLength: UIScreen.main.bounds.height / 3)
    }
    .padding(.horizontal, 20)
    .animation(.linear, value: viewStore.buttonType)
    .onDisappear {
      store.send(.onDisappear)
    }
    .sheet(store: store.scope(state: \.$editSound, action: { .editAlarmSound($0) })) { store in
      EndTimerAlarmListView(store: store)
    }
  }
}

struct TimerView_Previews: PreviewProvider {
  static var previews: some View {
    TimerView()
      .previewLayout(.sizeThatFits)
  }
}

extension TimerView {
  
  private func timerUnitText(text: String) -> some View {
    Text(text)
      .font(.headline)
      .frame(width: 30, alignment: .leading)
      .foregroundColor(.white)
  }
  
  var timerView: some View {
    VStack(spacing: 20) {
      if viewStore.buttonType == .start {
        Spacer(minLength: UIScreen.main.bounds.height / 5)
        timerPicker
        Spacer()
      } else {
        Spacer()
        TimerProgressBarView(
          percent: viewStore.progressValue,
          currentTime: viewStore.currentTime,
          alarmTime: viewStore.endTimerTime
        )
        .padding(.horizontal, 20)
      }
    }
    .frame(height: UIScreen.main.bounds.height / 2)
  }
  
  var timerPicker: some View {
    ZStack(alignment: .center) {
      RepresentedPickerView(
        items: viewStore.pickerItems,
        selectedItemIndeces: viewStore.binding(
          get: \.selectedTimes,
          send: { .didSelectPickerItems($0) }
        )
      )
      HStack(spacing: 0) {
        Spacer()
        timerUnitText(text: "시간")
          .offset(x: 32)
        Spacer()
        timerUnitText(text: "분")
          .offset(x: 32)
        Spacer()
        timerUnitText(text: "초")
          .offset(x: 32)
        Spacer()
      }
      .foregroundColor(.white)
    }
  }
  
  var timerButtons: some View {
    HStack(spacing: 0) {
      StopWatchButton(
        title: "취소",
        type: .gray
      ) {
        store.send(.didTapCancelButton)
      }
      Spacer()
      StopWatchButton(
        title: viewStore.buttonType.buttonTitle,
        type: viewStore.buttonType.color
      ) {
        store.send(.didTapStartButton)
      }
    }
  }
}
