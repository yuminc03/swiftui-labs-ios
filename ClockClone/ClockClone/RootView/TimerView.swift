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
    var pickerItems = [
      (0 ..< 24).map { $0.description },
      (0 ..< 60).map { $0.description },
      (0 ..< 60).map { $0.description }
    ]
    var selectedIndeces = [0, 0, 0]
  }
  
  enum Action {
    case didSelectTime(Int)
    case didSelectMinute(Int)
    case didSelectSecond(Int)
    case didSelectPickerItems([Int])
  }
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
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
      return .none
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
      Spacer()
      timerPicker
      Spacer()
      VStack(spacing: 40) {
        timerButtons
        TimerSoundRow(title: "타이머 종료 시", selectedName: "프레스토")
      }
      Spacer(minLength: UIScreen.main.bounds.height / 3)
    }
    .padding(.horizontal, 20)
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
    VStack {
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
  }
  
  var timerButtons: some View {
    HStack(spacing: 0) {
      StopWatchButton(
        title: "취소",
        type: .darkGray
      ) {
        
      }
      Spacer()
      StopWatchButton(
        title: "시작",
        type: .green
      ) {

      }
    }
  }
}
