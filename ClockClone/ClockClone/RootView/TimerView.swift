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
    var selectedTime = 0
    var selectedMinute = 0
    var selectedSecond = 0
    var greenButtonType: GreenButtonType = .start
    var isStartButtonDisabled = true
    var isCancelButtonDisabled = true
    var pickerItems = [
      (0 ..< 24).map { $0.description },
      (0 ..< 60).map { $0.description },
      (0 ..< 60).map { $0.description }
    ]
    var selectedIndeces = [0, 0, 0]
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
    case didSelectTime(Int)
    case didSelectMinute(Int)
    case didSelectSecond(Int)
    case didSelectPickerItems([Int])
    case didTapTimerSoundRow
    case editAlarmSound(PresentationAction<EndTimerAlarmListCore.Action>)
    case didTapStartButton
    case didTapCancelButton
    case timerAction
    case timerTicked
  }
  
  private enum CancelID {
    case timer
  }
  
  @Dependency(\.continuousClock) var timer
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case let .didSelectTime(hour):
        state.selectedTime = hour
        return .none
        
      case let .didSelectMinute(minute):
        state.selectedMinute = minute
        return .none
        
      case let .didSelectSecond(second):
        state.selectedSecond = second
        return .none
        
      case let .didSelectPickerItems(indeces):
        state.selectedIndeces = indeces
        if state.selectedIndeces.map ({ $0 == 0 }).contains(false) {
          state.isStartButtonDisabled = false
        } else {
          state.isStartButtonDisabled = true
        }
        state.selectedTime = Int(state.pickerItems[0][state.selectedIndeces[0]]) ?? 0
        state.selectedMinute = Int(state.pickerItems[1][state.selectedIndeces[1]]) ?? 0
        state.selectedSecond = Int(state.pickerItems[2][state.selectedIndeces[2]]) ?? 0
        return .none
        
      case .didTapTimerSoundRow:
        state.editSound = EndTimerAlarmListCore.State()
        return .none
        
      case .editAlarmSound:
        return .none
        
      case .didTapStartButton:
        switch state.greenButtonType {
        case .start:
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
        return .none
        
      case .didTapCancelButton:
        state.greenButtonType = .start
        state.isCancelButtonDisabled = true
        return .none
        
      case .timerAction:
        return .run { [buttonType = state.greenButtonType] send in
          guard buttonType != .start else { return }
          for await _ in timer.timer(interval: .seconds(1)) {
            await send(.timerTicked)
          }
        }
        .cancellable(id: CancelID.timer)
        
      case .timerTicked:
        return .none
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
    VStack {
      if viewStore.greenButtonType == .start {
        Spacer()
        timerPicker
        Spacer()
      } else {
        TimerProgressBarView(
          percent: 90,
          hour: "",
          minute: "11",
          second: "00",
          alarmTime: "오후 4:00"
        )
      }
      VStack(spacing: 40) {
        timerButtons
        TimerSoundRow(title: "타이머 종료 시", selectedName: "프레스토") {
          store.send(.didTapTimerSoundRow)
        }
      }
      Spacer(minLength: UIScreen.main.bounds.height / 3)
    }
    .padding(.horizontal, 20)
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
  
  var timerPicker: some View {
    ZStack(alignment: .center) {
      RepresentedPickerView(
        items: viewStore.pickerItems,
        selectedItemIndeces: viewStore.binding(
          get: \.selectedIndeces,
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
