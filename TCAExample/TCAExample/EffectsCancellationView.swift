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
  }
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case let .didChangeStepper(number):
      state.count = number
      state.numberFact = nil
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
              
            }
          }
        }
      }
    }
  }
}

struct EffectsCancellationView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      EffectsCancellationView()
    }
  }
}
