//
//  ContactsFeature.swift
//  ContactsApp
//
//  Created by Yumin Chu on 2023/08/25.
//

import Foundation
import SwiftUI

import ComposableArchitecture

struct Contact: Equatable, Identifiable {
  let id: UUID
  var name: String
}

struct ContactsFeature: Reducer {
  struct State: Equatable {
    var contacts: IdentifiedArrayOf<Contact> = []
//    @PresentationState var addContact: AddContactFeature.State?
//    @PresentationState var alert: AlertState<Action.Alert>?
    @PresentationState var destination: Destination.State?
    var path = StackState<ContactDetailFeature.State>()
  }
  
  enum Action: Equatable {
    case didTapAddButton
    case didTapDeleteButton(id: Contact.ID)
//    case addContact(PresentationAction<AddContactFeature.Action>)
//    case alert(PresentationAction<Alert>)
    case destination(PresentationAction<Destination.Action>)
    case path(StackAction<ContactDetailFeature.State, ContactDetailFeature.Action>)
    
    enum Alert: Equatable {
      case confirmDeletion(id: Contact.ID)
    }
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .didTapAddButton:
        state.destination = .addContact(AddContactFeature.State(
          contact: Contact(id: UUID(), name: "")
        ))
//        state.addContact = AddContactFeature.State(
//          contact: Contact(id: UUID(), name: "")
//        )
        return .none
        
//      case .addContact(.presented(.delegate(.cancel))):
//        state.addContact = nil
//        return .none
        
      case let .destination(.presented(.addContact(.delegate(.save(contact))))):
//      case let .addContact(.presented(.delegate(.save(contact)))):
//        guard let contact = state.addContact?.contact else { return .none }
        state.contacts.append(contact)
//        state.addContact = nil
        return .none
        
//      case .addContact:
//        return .none
//
      case let .didTapDeleteButton(id: id):
        state.destination = .alert(AlertState(title: {
          TextState("Are you sure?")
        }, actions: {
          ButtonState(role: .destructive, action: .confirmDeletion(id: id)) {
            TextState("Delete")
          }
        }))
//        state.alert = AlertState(title: {
//          TextState("Are you sure?")
//        }, actions: {
//          ButtonState(role: .destructive, action: .confirmDeletion(id: id)) {
//            TextState("Delete")
//          }
//        })
        return .none
        
      case let .destination(.presented(.alert(.confirmDeletion(id: id)))):
//      case let .alert(.presented(.confirmDeletion(id: id))):
        state.contacts.remove(id: id)
        return .none
        
      case .destination:
//      case .alert:
        return .none
        
      case let .path(.element(id: id, action: .delegate(.confirmDeletion))):
        guard let detailState = state.path[id: id] else {
          return .none
        }
        
        state.contacts.remove(id: detailState.contact.id)
        return .none
        
      case .path:
        return .none
      }
    }
    .ifLet(\.$destination, action: /Action.destination) {
      Destination()
    }
    .forEach(\.path, action: /Action.path) {
      ContactDetailFeature()
    }
//    .ifLet(\.$addContact, action: /Action.addContact) {
//      AddContactFeature()
//    }
//    .ifLet(\.$alert, action: /Action.alert)
  }
}

extension ContactsFeature {
  
  struct Destination: Reducer {
    
    enum State: Equatable {
      case addContact(AddContactFeature.State)
      case alert(AlertState<ContactsFeature.Action.Alert>)
    }
    
    enum Action: Equatable {
      case addContact(AddContactFeature.Action)
      case alert(ContactsFeature.Action.Alert)
    }
    
    var body: some ReducerOf<Self> {
      Scope(state: /State.addContact, action: /Action.addContact) {
        AddContactFeature()
      }
    }
  }
}



struct ContactsView: View {
  private let store: StoreOf<ContactsFeature>
  
  init(store: StoreOf<ContactsFeature>) {
    self.store = store
  }

  var body: some View {
    NavigationStackStore(store.scope(state: \.path, action: { .path($0) })) {
      WithViewStore(self.store, observe: \.contacts) { viewStore in
        List {
          ForEach(viewStore.state) { contact in
            NavigationLink(state: ContactDetailFeature.State(contact: contact)) {
              HStack {
                Text(contact.name)
                Spacer()
                Button {
                  viewStore.send(.didTapDeleteButton(id: contact.id))
                } label: {
                  Image(systemName: "trash")
                    .foregroundColor(.red)
                }
              }
            }
            .buttonStyle(.borderless)
          }
        }
        .navigationTitle("Contacts")
        .toolbar {
          ToolbarItem {
            Button {
              viewStore.send(.didTapAddButton)
            } label: {
              Image(systemName: "plus")
            }
          }
        }
      }
    } destination: { detailStore in
      ContactDetailView(store: detailStore)
    }
    .sheet(
      store: store.scope(state: \.$destination, action: { .destination($0) }),
      state: /ContactsFeature.Destination.State.addContact,
      action: ContactsFeature.Destination.Action.addContact
    ) { store in
      NavigationStack {
        AddContactView(store: store)
      }
    }
    .alert(
      store: store.scope(state: \.$destination, action: { .destination($0) }),
      state: /ContactsFeature.Destination.State.alert,
      action: ContactsFeature.Destination.Action.alert
    )
//    .sheet(store: store.scope(state: \.$addContact, action: { .addContact($0) })) { addContactStore in
//      NavigationStack {
//        AddContactView(store: addContactStore)
//      }
//    }
//    .alert(store: store.scope(state: \.$alert, action: { .alert($0) }))
  }
}

struct ContactsView_Previews: PreviewProvider {
  static var previews: some View {
    ContactsView(
      store: Store(
        initialState: ContactsFeature.State(
          contacts: [
            Contact(id: UUID(), name: "Eaily"),
            Contact(id: UUID(), name: "Kaila"),
            Contact(id: UUID(), name: "Crystal")
          ]
        )
      ) {
        ContactsFeature()
      }
    )
  }
}
