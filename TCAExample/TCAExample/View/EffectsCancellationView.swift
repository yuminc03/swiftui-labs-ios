//
//  EffectsCancellationView.swift
//  TCAExample
//
//  Created by Yumin Chu on 2023/10/18.
//

import SwiftUI

import ComposableArchitecture

struct EffectsCancellationCore: Reducer {
  struct State: Equatable {
    var count = 0
    var numberFact: String?
    var isNumberFactLoading = false
  }
  
  enum Action: Equatable {
    case didChangeStepper(Int)
    case didTapCancelButton
    case didTapFactButton
    case factResponse(TaskResult<String>)
  }
  
  @Dependency(\.factClient) var factClient
  private enum CancelID {
    case fact
  }
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case let .didChangeStepper(number):
      state.count = number
      state.numberFact = nil
      state.isNumberFactLoading = false
      return .cancel(id: CancelID.fact)
      
    case .didTapCancelButton:
      state.isNumberFactLoading = false
      return .cancel(id: CancelID.fact)
      
    case .didTapFactButton:
      state.numberFact = nil
      state.isNumberFactLoading = true
      return .run { [state] send in
        await send(.factResponse(TaskResult {
          try await factClient.fetch(state.count)
        }))
      }
      .cancellable(id: CancelID.fact)
      
    case let .factResponse(.success(fact)):
      state.isNumberFactLoading = false
      state.numberFact = fact
      return .none
      
    case .factResponse(.failure):
      state.isNumberFactLoading = false
      return .none
    }
  }
}

struct EffectsCancellationView: View {
  let store: StoreOf<EffectsCancellationCore>
  @ObservedObject var viewStore: ViewStoreOf<EffectsCancellationCore>
  
  init() {
    self.store = Store(initialState: .init()) { EffectsCancellationCore() }
    self.viewStore = ViewStore(self.store, observe: { $0 })
  }
  
  var body: some View {
    Form {
      Section {
        Stepper(
          "\(viewStore.count)",
          value: viewStore.binding(get: \.count, send: { .didChangeStepper($0) })
        )
        
        if viewStore.isNumberFactLoading {
          HStack {
            Button("Cancel") {
              viewStore.send(.didTapCancelButton)
            }
            Spacer()
            ProgressView()
          }
        } else {
          Button("Number Fact") {
            viewStore.send(.didTapFactButton)
          }
          .disabled(viewStore.isNumberFactLoading)
        }
        
        if let numberFact = viewStore.numberFact {
          Text(numberFact)
            .padding(.vertical, 10)
        }
      }
    }
    .navigationTitle("Effect cancellation")
  }
}

struct EffectsCancellationView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      EffectsCancellationView()
    }
  }
}
