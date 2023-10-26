//
//  ScreenAView.swift
//  TCAExample
//
//  Created by Yumin Chu on 2023/10/25.
//

import SwiftUI

import ComposableArchitecture

struct ScreenACore: Reducer {
  struct State: Codable, Equatable, Hashable {
    var count = 0
    var fact: String?
    var isLoading = false
  }
  
  enum Action {
    case didTapDecrementButton
    case didTapIncrementButton
    case didTapDismissButton
    case didTapFactButton
    case factResponse(TaskResult<String>)
  }
  
  @Dependency(\.dismiss) var dismiss
  @Dependency(\.factClient) var factClient
 
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case .didTapDecrementButton:
      state.count -= 1
      return .none
      
    case .didTapIncrementButton:
      state.count += 1
      return .none
      
    case .didTapDismissButton:
      return .run { send in
        await dismiss()
      }
      
    case .didTapFactButton:
      state.isLoading = true
      return .run { [state] send in
        await send(.factResponse(.init {
          try await factClient.fetch(state.count)
        }))
      }
      
    case let .factResponse(.success(fact)):
      state.fact = fact
      return .none
      
    case .factResponse(.failure):
      state.fact = nil
      state.isLoading = false
      return .none
    }
  }
}

struct ScreenAView: View {
  private let store: StoreOf<ScreenACore>
  @ObservedObject private var viewStore: ViewStoreOf<ScreenACore>
  
  init(store: StoreOf<ScreenACore>) {
    self.store = store
    self.viewStore = .init(store, observe: { $0 })
  }
  
  var body: some View {
    Form {
      HStack {
        Text("\(viewStore.count)")
        Spacer()
        Button {
          viewStore.send(.didTapDecrementButton)
        } label: {
          Image(systemName: "minus")
        }
        Button {
          viewStore.send(.didTapIncrementButton)
        } label: {
          Image(systemName: "plus")
        }
      }
      .buttonStyle(.borderless)
      
      Button {
        viewStore.send(.didTapFactButton)
      } label: {
        HStack {
          Text("Get fact")
          if viewStore.isLoading {
            Spacer()
            ProgressView()
          }
        }
      }

      if let fact = viewStore.fact {
        Text(fact)
      }
      
      Section {
        Button("Dismiss") {
          viewStore.send(.didTapDismissButton)
        }
      }
      
      Section {
        NavigationLink(
          "Go to screen A",
          state: NavigationDemoCore.Path.State.screenA(.init(count: viewStore.count))
        )
        NavigationLink(
          "Go to screen B",
          state: NavigationDemoCore.Path.State.screenB()
        )
        NavigationLink(
          "Go to screen C",
          state: NavigationDemoCore.Path.State.screenC(.init(count: viewStore.count))
        )
      }
    }
    .navigationTitle("Screen A")
  }
}

struct ScreenAView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      ScreenAView(store: .init(initialState: ScreenACore.State()) {
        ScreenACore()
      })
    }
  }
}
