//
//  RefreshableView.swift
//  TCAExample
//
//  Created by Yumin Chu on 2023/10/21.
//

import SwiftUI

import ComposableArchitecture

struct RefreshableCore: Reducer {
  struct State: Equatable {
    var count = 0
    var isLoading = false
    var factString: String?
  }
  
  enum Action: Equatable {
    case didTapMinusButton
    case didTapPlusButton
    case isLoading(Bool)
    case factResponse(TaskResult<String>)
    case didTapCancelButton
    case refresh
  }
  
  @Dependency(\.factClient) var factClient
  private enum CancelID {
    case factResponse
  }
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case .didTapMinusButton:
      state.count -= 1
      return .none
      
    case .didTapPlusButton:
      state.count += 1
      return .none
      
    case let .isLoading(isLoading):
      state.isLoading = isLoading
      return .none
      
    case let .factResponse(.success(fact)):
      state.factString = fact
      return .none
      
    case .factResponse(.failure):
      return .none
      
    case .didTapCancelButton:
      return .cancel(id: CancelID.factResponse)
      
    case .refresh:
      return .run { [state] send in
        await send(
          .factResponse(TaskResult {
            try await factClient.fetch(state.count)
          }), animation: .default
        )
      }
      .cancellable(id: CancelID.factResponse)
    }
  }
}

struct RefreshableView: View {
  private let store: StoreOf<RefreshableCore>
  private var viewStore: ViewStoreOf<RefreshableCore>
  
  init() {
    self.store = .init(initialState: RefreshableCore.State()) {
      RefreshableCore()
    }
    self.viewStore = .init(store, observe: { $0 })
  }
  
  var body: some View {
    Form {
      HStack(spacing: 10) {
        Button {
          store.send(.didTapMinusButton)
        } label: {
          Image(systemName: "minus")
        }
        Text("\(viewStore.count)")
          .monospacedDigit()
        Button {
          store.send(.didTapPlusButton)
        } label: {
          Image(systemName: "plus")
        }
      }
      .frame(maxWidth: .infinity)
      .buttonStyle(.borderless)
      
      if let fact = viewStore.factString {
        Text(fact)
          .fontWeight(.bold)
      }
      
      if viewStore.isLoading {
        Button("Cancel") {
          store.send(.didTapCancelButton)
        }
      }
    }
    .refreshable {
      store.send(.isLoading(true))
      defer {
        store.send(.isLoading(false))
      }
      await store.send(.refresh).finish()
    }
    .navigationTitle("Refreshable")
  }
}

struct RefreshableView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      RefreshableView()
    }
  }
}
