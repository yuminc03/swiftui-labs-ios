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
  }
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case .didTapMinusButton:
      state.count -= 1
      state.numberFact = nil
      return .none
      
    case .didTapPlusButton:
      state.count += 1
      state.numberFact = nil
      return .none
      
    case .didTapNumberFactButton:
      state.isNumberFactLoading = true
      state.numberFact = nil
      return .none
      
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
    self.viewStore = ViewStore(store, observe: { $0 })
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
