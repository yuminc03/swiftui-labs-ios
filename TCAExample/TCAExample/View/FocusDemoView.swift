//
//  FocusDemoView.swift
//  TCAExample
//
//  Created by Yumin Chu on 2023/10/24.
//

import SwiftUI

import ComposableArchitecture

struct FocusDemoCore: Reducer {
  struct State: Equatable {
    @BindingState var focusField: Field?
    @BindingState var userName = ""
    @BindingState var password = ""
    
    enum Field: String, Hashable {
      case userName
      case password
    }
  }
  
  enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case didTapSignInButton
  }
  
  var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
        
      case .didTapSignInButton:
        if state.userName.isEmpty {
          state.focusField = .userName
        } else if state.password.isEmpty {
          state.focusField = .password
        }
        return .none
      }
    }
  }
}

struct FocusDemoView: View {
  private let store: StoreOf<FocusDemoCore>
  @ObservedObject private var viewStore: ViewStoreOf<FocusDemoCore>
  @FocusState private var focusedField: FocusDemoCore.State.Field?
  
  init() {
    self.store = .init(initialState: FocusDemoCore.State()) {
      FocusDemoCore()
        ._printChanges()
    }
    self.viewStore = .init(store, observe: { $0 })
  }
  
  var body: some View {
    Form {
      VStack(spacing: 10) {
        TextField("UserName", text: viewStore.$userName)
          .focused($focusedField, equals: .userName)
        
        TextField("Password", text: viewStore.$password)
          .focused($focusedField, equals: .password)
        
        Button("Sign In") {
          viewStore.send(.didTapSignInButton)
        }
        .buttonStyle(.borderedProminent)
      }
      .textFieldStyle(.roundedBorder)
    }
    .bind(viewStore.$focusField, to: $focusedField)
    .navigationTitle("Focus demo")
  }
}

struct FocusDemoView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      FocusDemoView()
    }
  }
}
