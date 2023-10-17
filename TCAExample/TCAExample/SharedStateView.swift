//
//  SharedStateView.swift
//  TCAExample
//
//  Created by Yumin Chu on 2023/10/16.
//

import SwiftUI

import ComposableArchitecture

struct SharedStateCore: Reducer {
  enum Tab {
    case counter
    case profile
  }
  
  struct State: Equatable {
    var currentTab = Tab.counter
    var counter = Counter.State()
    var profile: Profile.State {
      get {
        Profile.State(
          currentTab: currentTab,
          count: counter.count,
          maxCount: counter.maxCount,
          minCount: counter.minCount,
          numberOfCounts: counter.numberOfCounts
        )
      }
      set {
        self.currentTab = newValue.currentTab
        self.counter.count = newValue.count
        self.counter.maxCount = newValue.maxCount
        self.counter.minCount = newValue.minCount
        self.counter.numberOfCounts = newValue.numberOfCounts
      }
    }
  }
  
  enum Action {
    case selectTab(Tab)
    case counter(Counter.Action)
    case profile(Profile.Action)
  }
  
  var body: some ReducerOf<Self> {
    Scope(state: \.counter, action: /Action.counter) {
      Counter()
    }
    Scope(state: \.profile, action: /Action.profile) {
      Profile()
    }
    Reduce { state, action in
      switch action {
      case .counter, .profile:
        return .none
        
      case let .selectTab(tab):
        state.currentTab = tab
        return .none
      }
    }
  }
  
  struct Counter: Reducer {
    struct State: Equatable {
      var count = 0
      var maxCount = 0
      var minCount = 0
      var numberOfCounts = 0
      @PresentationState var alert: AlertState<Action.Alert>?
    }
    
    enum Action {
      case didTapDecrementButton
      case didTapIncrementButton
      case didTapIsPrimeButton
      case alert(PresentationAction<Alert>)
      enum Alert: Equatable { }
    }
    
    var body: some ReducerOf<Self> {
      Reduce { state, action in
        switch action {
        case .didTapDecrementButton:
          state.count -= 1
          state.numberOfCounts += 1
          state.minCount = min(state.minCount, state.count)
          return .none
          
        case .didTapIncrementButton:
          state.count += 1
          state.numberOfCounts += 1
          state.maxCount = max(state.maxCount, state.count)
          return .none
          
        case .didTapIsPrimeButton:
          state.alert = AlertState {
            TextState(
              isPrime(state.count)
              ? "👍 The number \(state.count) is prime!"
              : "👎 The number \(state.count) is not prime :("
            )
          }
          return .none
          
        case .alert:
          return .none
        }
      }
      .ifLet(\.$alert, action: /Action.alert)
    }
  }
  
  struct Profile: Reducer {
    struct State: Equatable {
      private(set) var currentTab: Tab
      private(set) var count = 0
      private(set) var maxCount: Int
      private(set) var minCount: Int
      private(set) var numberOfCounts: Int
      
      mutating func resetCount() {
        self.currentTab = .counter
        self.count = 0
        self.maxCount = 0
        self.minCount = 0
        self.numberOfCounts = 0
      }
    }
    
    enum Action {
      case reset
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
      switch action {
      case .reset:
        state.resetCount()
        return .none
      }
    }
  }
}

struct SharedStateView: View {
  private let store: StoreOf<SharedStateCore>
  @ObservedObject private var viewStore: ViewStore<SharedStateCore.Tab, SharedStateCore.Action>
  
  init() {
    self.store = .init(initialState: SharedStateCore.State()) {
      SharedStateCore()
    }
    self.viewStore = .init(store, observe: \.currentTab)
  }
  
  var body: some View {
    VStack {
      Picker(
        "Tab",
        selection: viewStore.binding(send: { .selectTab($0) })
      ) {
        Text("Counter")
          .tag(SharedStateCore.Tab.counter)
        
        Text("Profile")
          .tag(SharedStateCore.Tab.profile)
      }
      .pickerStyle(.segmented)
      
      if viewStore.state == .counter {
        SharedStateCounterView(
          store: store.scope(
            state: \.counter,
            action: { .counter($0) }
          )
        )
      }
      
      if viewStore.state == .profile {
        
      }
    }
    .padding(20)
  }
}

struct SharedStateView_Previews: PreviewProvider {
  static var previews: some View {
    SharedStateView()
  }
}

private func isPrime(_ number: Int) -> Bool {
  if number <= 1 {
    return false
  }
  if number <= 3 {
    return true
  }
  for i in 2 ... Int(sqrtf(Float(number))) {
    if number % i == 0 {
      return false
    }
  }
  return true
}

struct SharedStateCounterView: View {
  private let store: StoreOf<SharedStateCore.Counter>
  @ObservedObject private var viewStore: ViewStoreOf<SharedStateCore.Counter>
  
  init(store: StoreOf<SharedStateCore.Counter>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: { $0 })
  }
  
  var body: some View {
    VStack(spacing: 20) {
      Spacer()
      HStack(spacing: 10) {
        Button {
          store.send(.didTapDecrementButton)
        } label: {
          Image(systemName: "minus")
        }
        
        Text("\(viewStore.count)")
          .monospacedDigit()
        
        Button {
          store.send(.didTapIncrementButton)
        } label: {
          Image(systemName: "plus")
        }
      }
      
      Button("Is this prime?") {
        viewStore.send(.didTapIsPrimeButton)
      }
      
      Spacer()
    }
    .navigationTitle("Shared State Demo")
    .alert(store: store.scope(state: \.$alert, action: { .alert($0) }))
  }
}
