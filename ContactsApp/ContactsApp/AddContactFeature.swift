//
//  AddContactFeature.swift
//  ContactsApp
//
//  Created by Yumin Chu on 2023/08/25.
//

import SwiftUI

import ComposableArchitecture

struct AddContactFeature: Reducer {
  struct State: Equatable {
    var contact: Contact
  }
  
  enum Action: Equatable {
    case didTapCancelButton
    case didTapSaveButton
    case setName(String)
    case delegate(Delegate)
    
    enum Delegate: Equatable {
//      case cancel
      case save(Contact)
    }
  }
  
  @Dependency(\.dismiss) var dismiss
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case .didTapCancelButton:
      return .run { _ in
        await dismiss()
      }

    case .didTapSaveButton:
      return .run { [contact = state.contact] send in
        await send(.delegate(.save(contact)))
        await dismiss()
      }

    case let .setName(name):
      state.contact.name = name
      return .none
      
    case .delegate:
      return .none
    }
  }
}

struct AddContactView: View {
  private let store: StoreOf<AddContactFeature>
  
  init(store: StoreOf<AddContactFeature>) {
    self.store = store
  }

  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      Form {
        TextField("Name", text: viewStore.binding(get: \.contact.name, send: { .setName($0) }))
        Button("Save") {
          viewStore.send(.didTapSaveButton)
        }
      }
      .toolbar {
        ToolbarItem {
          Button("Cancel") {
            viewStore.send(.didTapCancelButton)
          }
        }
      }
    }
  }
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
      NavigationStack {
           AddContactView(
             store: Store(
               initialState: AddContactFeature.State(
                 contact: Contact(
                   id: UUID(),
                   name: "Yumin"
                 )
               )
             ) {
               AddContactFeature()
             }
           )
         }
    }
}
