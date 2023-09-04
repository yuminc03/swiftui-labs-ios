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
  }
  
  enum Action {
    case didSelectTime(Int)
    case didSelectMinute(Int)
    case didSelectSecond(Int)
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
    ZStack {
      Color.black
        .ignoresSafeArea()
      VStack {
        ZStack(alignment: .center) {
          HStack(spacing: 0) {
            Spacer()
            Text("시간")
              .font(.headline)
              .offset(x: -25)
            Spacer()
            Text("분")
              .font(.headline)
              .offset(x: -25)
            Spacer()
            Text("초")
              .font(.headline)
              .offset(x: -25)
          }
          .foregroundColor(.white)
          RoundedRectangle(cornerRadius: 10)
            .foregroundColor(.white.opacity(0.1))
            .frame(height: 30)
          HStack(spacing: 0) {
            Picker(
              "selected time",
              selection: viewStore.binding(get: \.selectedTime, send: { .didSelectTime($0) })
            ) {
              ForEach(0 ..< 24) { number in
                Text("\(number)")
                  .foregroundColor(.white)
              }
            }
            .pickerStyle(.wheel)
            Picker(
              "selected minute",
              selection: viewStore.binding(get: \.selectedMinute, send: { .didSelectMinute($0) })
            ) {
              ForEach(0 ..< 60) { number in
                Text("\(number)")
                  .foregroundColor(.white)
              }
            }
            .pickerStyle(.wheel)
            Picker(
              "selected second",
              selection: viewStore.binding(get: \.selectedSecond, send: { .didSelectSecond($0) })
            ) {
              ForEach(0 ..< 60) { number in
                Text("\(number)")
                  .foregroundColor(.white)
              }
            }
            .pickerStyle(.wheel)
          }
        }
      }
      .padding(.horizontal, 20)
    }
  }
}

struct TimerView_Previews: PreviewProvider {
  static var previews: some View {
    TimerView()
      .previewLayout(.sizeThatFits)
  }
}
