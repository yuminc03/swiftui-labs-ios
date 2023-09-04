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
    case didSelectTime
    case didSelectMinute
    case didSelectSecond
  }
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case .didSelectTime:
      return .none
      
    case .didSelectMinute:
      return .none
      
    case .didSelectSecond:
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
    }
    self.viewStore = ViewStore(store, observe: { $0 })
  }
  
  var body: some View {
    ZStack {
      Color.black
        .ignoresSafeArea()
      VStack {
        ZStack(alignment: .center) {
//          HStack(spacing: 0) {
//            Text("시간")
//            Spacer()
//            Text("분")
//            Spacer()
//            Text("초")
//          }
//          .foregroundColor(.white)
          RoundedRectangle(cornerRadius: 10)
            .foregroundColor(.white.opacity(0.1))
            .frame(height: 30)
          HStack(spacing: 0) {
            Picker(
              "selected time",
              selection: viewStore.binding(get: \.selectedTime, send: .didSelectTime)
            ) {
              ForEach(0 ..< 24) { number in
                Text("\(number)")
                  .foregroundColor(.white)
              }
            }
            .pickerStyle(.wheel)
            Picker(
              "selected minute",
              selection: viewStore.binding(get: \.selectedTime, send: .didSelectTime)
            ) {
              ForEach(0 ..< 60) { number in
                Text("\(number)")
                  .foregroundColor(.white)
              }
            }
            .pickerStyle(.wheel)
            Picker(
              "selected second",
              selection: viewStore.binding(get: \.selectedTime, send: .didSelectTime)
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
  }
}
