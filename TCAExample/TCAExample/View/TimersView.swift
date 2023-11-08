//
//  TimersView.swift
//  TCAExample
//
//  Created by Yumin Chu on 2023/10/25.
//

import SwiftUI

import ComposableArchitecture

struct TimersCore: Reducer {
  struct State: Equatable {
    var secondsElapsed = 0
    var isTimerActive = false
  }
  
  enum Action {
    case didTapToggleTimerButton
    case timerTicked
    case onDisappear
  }
  
  @Dependency(\.continuousClock) var clock
  private enum CancelID {
    case timer
  }
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case .didTapToggleTimerButton:
      state.isTimerActive.toggle()
      return .run { [state] send in
        guard state.isTimerActive else { return }
        for await _ in clock.timer(interval: .seconds(1)) {
          await send(
            .timerTicked,
            animation: .interpolatingSpring(stiffness: 3000, damping: 40)
          )
        }
      }
      .cancellable(id: CancelID.timer, cancelInFlight: true)
    
    case .timerTicked:
      state.secondsElapsed += 1
      return .none
      
    case .onDisappear:
      return .cancel(id: CancelID.timer)
    }
  }
}

struct TimersView: View {
  private let store: StoreOf<TimersCore>
  @ObservedObject private var viewStore: ViewStoreOf<TimersCore>
  
  init() {
    self.store = .init(initialState: TimersCore.State()) {
      TimersCore()
    }
    self.viewStore = .init(store, observe: { $0 })
  }
  
  var body: some View {
    Form {
      ZStack {
        Circle()
          .fill(
            AngularGradient(
              gradient: Gradient(
                colors: [
                  .blue.opacity(0.3),
                  .blue,
                  .blue,
                  .green,
                  .green,
                  .yellow,
                  .yellow,
                  .red,
                  .red,
                  .purple,
                  .purple,
                  .purple.opacity(0.3)
                ]
              ),
              center: .center
            )
          )
          .rotationEffect(.degrees(-90))
        GeometryReader { proxy in
          Path { path in
            path.move(
              to: CGPoint(x: proxy.size.width / 2, y: proxy.size.height / 2)
            )
            path.addLine(to: CGPoint(x: proxy.size.width / 2, y: 0))
          }
          .stroke(.primary, lineWidth: 3)
          .rotationEffect(
            .degrees(Double(viewStore.secondsElapsed) * 360 / 60)
          )
        }
      }
      .aspectRatio(1, contentMode: .fit)
      .frame(maxWidth: 280)
      .frame(maxWidth: .infinity)
      .padding(.vertical, 16)
      
      Button {
        viewStore.send(.didTapToggleTimerButton)
      } label: {
        Text(viewStore.isTimerActive ? "Stop" : "Start")
          .padding(8)
      }
      .frame(maxWidth: .infinity)
      .tint(viewStore.isTimerActive ? Color.red : .accentColor)
      .buttonStyle(.borderedProminent)
    }
    .navigationTitle("Timers")
    .onDisappear {
      viewStore.send(.onDisappear)
    }
  }
}

struct TimersView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      TimersView()
    }
  }
}
