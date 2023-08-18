//
//  Timers.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/18.
//

import Foundation
import SwiftUI

import ComposableArchitecture

struct TimersReducer: Reducer {
    struct State: Equatable {
        var isTimerActive = false
        var secondsElapsed = 0
    }
    
    enum Action {
        case onDisappear
        case didTimerTicked
        case didTapTimerButton
    }
    
    @Dependency(\.continuousClock) var clock
    private enum CancelID {
        case timer
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .onDisappear:
            return .cancel(id: CancelID.timer)
            
        case .didTimerTicked:
            state.secondsElapsed += 1
            return .none
            
        case .didTapTimerButton:
            state.isTimerActive.toggle()
            return .run { [isTimerActive = state.isTimerActive] send in
                guard isTimerActive else { return }
                for await _ in clock.timer(interval: .seconds(1)) {
                    await send(.didTimerTicked, animation: .interpolatingSpring(stiffness: 3000, damping: 40))
                }
            }
            .cancellable(id: CancelID.timer, cancelInFlight: true)
        }
    }
}

struct Timers: View {
    
    private let store: StoreOf<TimersReducer>
    @ObservedObject private var viewStore: ViewStoreOf<TimersReducer>
    
    init() {
        let store = Store(initialState: TimersReducer.State()) {
            TimersReducer()
        }
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }
    
    var body: some View {
        Form {
            ZStack {
                Circle()
                    .fill(
                        AngularGradient(
                            gradient: Gradient(colors: [
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
                            ]),
                            center: .center
                        )
                    )
                    .rotationEffect(.degrees(-90))
                
            }
        }
    }
}
