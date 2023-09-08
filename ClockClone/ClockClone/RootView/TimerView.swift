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
    var hourText = "00"
    var minuteText = "00"
    var secondText = "00"
    var targetTime = ""
    var selectedTimerSeconds = 0
    var remainingSeconds = 0
    var greenButtonType: GreenButtonType = .start
    var isStartButtonDisabled = true
    var isCancelButtonDisabled = true
    var selectedTimes = [0, 0, 0]
    var selectedSound = "프레스토"
    var progressValue: CGFloat {
      return CGFloat(remainingSeconds) / (CGFloat(selectedTimerSeconds) / 100)
    }
    @PresentationState var editSound: EndTimerAlarmListCore.State?
    
    enum GreenButtonType {
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
  }
  
  enum Action {
    case didSelectPickerItems([Int])
    case didTapTimerSoundRow
    case editAlarmSound(PresentationAction<EndTimerAlarmListCore.Action>)
    case didTapStartButton
    case didTapCancelButton
    case timerAction
    case timerTicked
    case endedTimer
    case onDisappear
  }
  
  private enum CancelID {
    case timer
  }
  
  @Dependency(\.continuousClock) var timer
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case let .didSelectPickerItems(indeces):
        state.selectedTimes = indeces
        if state.selectedTimes.map ({ $0 == 0 }).contains(false) {
          state.isStartButtonDisabled = false
        } else {
          state.isStartButtonDisabled = true
        }
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
        switch state.greenButtonType {
        case .start:
          let selectedHour = state.selectedTimes[0]
          let selectedMinute = state.selectedTimes[1]
          let selectedSecond = state.selectedTimes[2]
          state.selectedTimerSeconds = (selectedHour * 3600) + (selectedMinute * 60) + selectedSecond
          state.remainingSeconds = (selectedHour * 3600) + (selectedMinute * 60) + selectedSecond
          state.greenButtonType = .pause
          
        case .pause:
          state.greenButtonType = .resume
          
        case .resume:
          state.greenButtonType = .pause
        }
        
        if state.greenButtonType != .start {
          state.isCancelButtonDisabled = false
        } else {
          state.isCancelButtonDisabled = true
        }
        
        return .run { send in
          await send(.timerAction)
        }
        
      case .didTapCancelButton:
        state.greenButtonType = .start
        state.isCancelButtonDisabled = true
        state.hourText = "00"
        state.minuteText = "00"
        state.secondText = "00"
        state.targetTime = ""
        state.selectedTimerSeconds = 0
        state.remainingSeconds = 0
        return .cancel(id: CancelID.timer)
        
      case .timerAction:
        return .run { [buttonType = state.greenButtonType] send in
          guard buttonType != .resume else { return }
          for await _ in timer.timer(interval: .seconds(1)) {
            await send(.timerTicked)
          }
        }
        .cancellable(id: CancelID.timer, cancelInFlight: true)
        
      case .timerTicked:
        guard state.remainingSeconds > 0 else {
          return .run { send in
            await send(.endedTimer)
          }
        }
        state.remainingSeconds -= 1
        let targetTime = Calendar.current.date(byAdding: .second, value: state.remainingSeconds, to: Date(), wrappingComponents: false) ?? Date()
        state.targetTime = DateFormat.convertTimeToString(
          date: targetTime,
          id: CityTime.korean.rawValue
        )
        state.hourText = convertToText(timerSeconds: state.remainingSeconds).hour
        state.minuteText = convertToText(timerSeconds: state.remainingSeconds).minute
        state.secondText = convertToText(timerSeconds: state.remainingSeconds).second
        return .none
        
      case .endedTimer:
        return .run { send in
          await send(.onDisappear)
          await send(.didTapCancelButton)
        }
        
      case .onDisappear:
        return .cancel(id: CancelID.timer)
      }
    }
    .ifLet(\.$editSound, action: /Action.editAlarmSound) {
      EndTimerAlarmListCore()
    }
  }
  
  private func convertToText(timerSeconds: Int) -> (hour: String, minute: String, second: String) {
    let hours = timerSeconds / 3600
    let minute = (timerSeconds - hours * 3600) / 60
    let seconds = timerSeconds % 60
    return (
      String(format: "%02d", hours),
      String(format: "%02d", minute),
      String(format: "%02d", seconds)
    )
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
    NavigationStack {
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
    }
    .padding(.horizontal, 20)
    .animation(.linear, value: viewStore.greenButtonType)
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
      if viewStore.greenButtonType == .start {
        Spacer(minLength: UIScreen.main.bounds.height / 5)
        timerPicker
        Spacer()
      } else {
        Spacer()
        TimerProgressBarView(
          percent: viewStore.progressValue,
          hour: viewStore.hourText,
          minute: viewStore.minuteText,
          second: viewStore.secondText,
          alarmTime: viewStore.targetTime
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
        type: viewStore.isCancelButtonDisabled ? .darkGray : .gray
      ) {
        store.send(.didTapCancelButton)
      }
      .disabled(viewStore.isCancelButtonDisabled)
      Spacer()
      StopWatchButton(
        title: viewStore.greenButtonType.buttonTitle,
        type: viewStore.greenButtonType.color
      ) {
        store.send(.didTapStartButton)
      }
      .disabled(viewStore.isStartButtonDisabled)
    }
  }
}
