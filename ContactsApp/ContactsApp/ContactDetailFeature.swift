//
//  ContactDetailFeature.swift
//  ContactsApp
//
//  Created by Yumin Chu on 2023/08/25.
//

import SwiftUI

import ComposableArchitecture

struct ContactDetailFeature: Reducer {
  struct State: Equatable {
    let contact: Contact
    @PresentationState var alert: AlertState<Action.Alert>?
  }
  
  enum Action: Equatable {
    case alert(PresentationAction<Alert>)
    case delegate(Delegate)
    case didTapDeleteButton
    
    enum Alert {
      case confirmDeletion
    }
    enum Delegate {
      case confirmDeletion
    }
  }
  
  @Dependency(\.dismiss) var dismiss
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .alert(.presented(.confirmDeletion)):
        return .run { send in
          await send(.delegate(.confirmDeletion))
          await dismiss()
        }
        
      case .didTapDeleteButton:
        state.alert = .confirmDeletion
        return .none
        
      case .alert:
        return .none
        
      case .delegate:
        return .none
      }
    }
    .ifLet(\.$alert, action: /Action.alert)
  }
}

extension AlertState where Action == ContactDetailFeature.Action.Alert {
  static let confirmDeletion = Self {
    TextState("Are you sure?")
  } actions: {
    ButtonState(role: .destructive, action: .confirmDeletion) {
      TextState("Delete")
    }
  }
}

struct ContactDetailView: View {
  private let store: StoreOf<ContactDetailFeature>
  
  init(store: StoreOf<ContactDetailFeature>) {
    self.store = store
  }
  
  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      Form {
        Button("Delete") {
          viewStore.send(.didTapDeleteButton)
        }
      }
      .navigationBarTitle(Text(viewStore.contact.name))
    }
    .alert(store: store.scope(state: \.$alert, action: { .alert($0) }))
  }
}

struct ContactDetailView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      ContactDetailView(
        store: Store(
          initialState: ContactDetailFeature.State(
            contact: Contact(id: UUID(), name: "Yumin")
          )
        ) {
          ContactDetailFeature()
        }
      )
    }
  }
}
