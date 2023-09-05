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
    var hourText = "00"
    var minuteText = "00"
    var secondsText = "00"
    var isStartButton = true
    var isTapStartButton = false
    var isTapStopButton = false
    var isTapReStartButton = false
  }
  
  enum Action {
    case didTapRapButton
    case didTapStartButton
    case didTapResetButton
    case didTapStopButton
    case didTapReStartButton
  }
  
  @Dependency(\.continuousClock) var clock
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case .didTapRapButton:
      return .none
      
    case .didTapStartButton:
      state.isTapStartButton = true
      state.isTapReStartButton = true
      state.isStartButton.toggle()
      return .none
      
    case .didTapResetButton:
      state.hourText = "00"
      state.minuteText = "00"
      state.secondsText = "00"
      state.isStartButton = true
      state.isTapStartButton = false
      state.isTapStopButton = false
      state.isTapReStartButton = false
      return .none
      
    case .didTapStopButton:
      state.isTapStopButton = true
      state.isStartButton.toggle()
      state.isTapReStartButton = false
      return .none
      
    case .didTapReStartButton:
      state.isTapReStartButton = true
      return .none
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
              stopWatchButton(
                title: "랩",
                type: viewStore.isTapStartButton ?.gray : .darkGray
              ) {
                store.send(.didTapRapButton)
              }
            } else if viewStore.isTapStopButton {
              stopWatchButton(
                title: "재설정",
                type: viewStore.isTapStartButton ?.gray : .darkGray
              ) {
                store.send(.didTapResetButton)
              }
            } else {
              stopWatchButton(
                title: "랩",
                type: viewStore.isTapStartButton ?.gray : .darkGray
              ) {
                store.send(.didTapRapButton)
              }
            }
            Spacer()
            if viewStore.isStartButton {
              stopWatchButton(title: "시작", type: .green) {
                store.send(.didTapStartButton)
              }
            } else {
              stopWatchButton(title: "중단", type: .red) {
                store.send(.didTapStopButton)
              }
            }
          }
        }
        .padding(.bottom, 10)
      }
      List {
        Divider()
          .background(.gray)
          .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
          .listRowSeparator(.hidden)
      }
      .listStyle(.plain)
      .frame(height: UIScreen.main.bounds.height / 3)
    }
    .padding(.horizontal, 20)
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
      Text("\(viewStore.hourText):\(viewStore.minuteText):\(viewStore.secondsText)")
        .fontWeight(.thin)
        .font(.system(size: 80))
        .minimumScaleFactor(0.01)
        .frame(maxWidth: .infinity)
      Text("Clock")
    }
    .foregroundColor(.white)
    .tabViewStyle(.page)
  }
  
  private func stopWatchButton(
    title: String,
    type: StopWatchButtonType,
    action: @escaping () -> Void
  ) -> some View {
    Text(title)
      .font(.body)
      .foregroundColor(type.titleColor)
      .frame(width: 90, height: 90)
      .background {
        ZStack(alignment: .center) {
          Circle()
            .fill(type.buttonColor)
            .frame(width: 90, height: 90)
          Circle()
            .fill(.black)
            .frame(height: 85)
          Circle()
            .fill(type.buttonColor)
            .frame(height: 80)
        }
      }
      .onTapGesture {
        action()
      }
  }
}
