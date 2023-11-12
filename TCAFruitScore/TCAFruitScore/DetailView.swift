//
//  DetailView.swift
//  TCAFruitScore
//
//  Created by Yumin Chu on 2023/11/12.
//

import SwiftUI

import ComposableArchitecture

struct DetailCore: Reducer {
  struct State: Equatable {
    let content: Score
  }
  
  enum Action {
    case didTapBackButton
    case delegate(Delegate)
    
    enum Delegate: Equatable {
      case increaseNumber
    }
  }
  
  @Dependency(\.dismiss) var dismiss
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .didTapBackButton:
        return .run { send in
          await send(.delegate(.increaseNumber))
          await dismiss()
        }
        
      case .delegate:
        return .none
      }
    }
  }
}

struct DetailView: View {
  private let store: StoreOf<DetailCore>
  @ObservedObject private var viewStore: ViewStoreOf<DetailCore>
  
  init(store: StoreOf<DetailCore>) {
    self.store = store
    self.viewStore = .init(store, observe: { $0 })
  }
  
  var body: some View {
    VStack(spacing: 10) {
      Text(viewStore.content.name)

      Button("Back") {
        store.send(.didTapBackButton)
      }
    }
  }
}

#Preview {
  DetailView(store: .init(initialState: DetailCore.State(content: .init(name: "사과는 1점", score: 1))) {
    DetailCore()
  })
}
