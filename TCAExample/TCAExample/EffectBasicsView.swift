//
//  EffectBasicsView.swift
//  TCAExample
//
//  Created by Yumin Chu on 2023/10/18.
//

import SwiftUI

import ComposableArchitecture

struct EffectBasicsCore: Reducer {
  struct State: Equatable {
    var count = 0
    var isNumberFactLoading = false
    var numberFact: String?
  }
  
  enum Action {
    case didTapMinusButton
    case didTapPlusButton
    case didTapNumberFactButton
    case numberFactResponse(TaskResult<String>)
    case decrementDelayResponse
  }
  
  @Dependency(\.factClient) var factClient
  @Dependency(\.continuousClock) var clock
  private enum CancelID {
    case delay
  }
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case .didTapMinusButton:
      state.count -= 1
      state.numberFact = nil
      return state.count >= 0 ? .none : .run { send in
        try await clock.sleep(for: .seconds(1))
        await send(.decrementDelayResponse)
      }
      .cancellable(id: CancelID.delay)
      
    case .didTapPlusButton:
      state.count += 1
      state.numberFact = nil
      return .none
      
    case .decrementDelayResponse:
      if state.count < 0 {
        state.count += 1
      }
      return .none
      
    case .didTapNumberFactButton:
      state.isNumberFactLoading = true
      state.numberFact = nil
      return .run { [state] send in
        await send(.numberFactResponse(TaskResult {
          try await factClient.fetch(state.count)
        }))
      }
      .cancellable(id: CancelID.delay)
      
    case let .numberFactResponse(.success(fact)):
      state.isNumberFactLoading = false
      state.numberFact = fact
      return .none
      
    case .numberFactResponse(.failure):
      state.isNumberFactLoading = false
      return .none
    }
  }
}

struct EffectBasicsView: View {
  private let store: StoreOf<EffectBasicsCore>
  @ObservedObject private var viewStore: ViewStoreOf<EffectBasicsCore>
  
  init() {
    let store = Store(initialState: EffectBasicsCore.State()) {
      EffectBasicsCore()
    }
    self.store = store
    self.viewStore = .init(store, observe: { $0 })
  }
  
  var body: some View {
    Form {
      Section {
        HStack {
          Button {
            viewStore.send(.didTapMinusButton)
          } label: {
            Image(systemName: "minus")
          }

          Text("\(viewStore.count)")
            .monospacedDigit()
          
          Button {
            viewStore.send(.didTapPlusButton)
          } label: {
            Image(systemName: "plus")
          }
        }
        .frame(maxWidth: .infinity)
        
        Button("Number fact") {
          viewStore.send(.didTapNumberFactButton)
        }
        .frame(maxWidth: .infinity)
        
        if viewStore.isNumberFactLoading {
          ProgressView()
            .frame(maxWidth: .infinity)
        }

        if let numberFact = viewStore.numberFact {
          Text(numberFact)
        }
      }
    }
    .navigationTitle("Effects")
  }
}

struct EffectBasicsView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      EffectBasicsView()
    }
  }
}
