//
//  Contact.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/21.
//

import Foundation

import ComposableArchitecture

struct ContactsReducer: Reducer {
    
    struct State: Equatable {
        var contacts: IdentifiedArrayOf<Contact> = []
        var path = StackState<ContactDetailPageReducer.State>()
        @PresentationState var destination: Destination.State?
    }
    
    enum Action {
        case didTapAddButton
        case didTapDeleteButton(id: Contact.ID)
        case destination(PresentationAction<Destination.Action>)
        case path(StackAction<ContactDetailPageReducer.State, ContactDetailPageReducer.Action>)
        enum Alert: Equatable {
            case confirmDeletion(id: Contact.ID)
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapAddButton:
                state.destination = .addContact(
                    ContactReducer.State(contact: Contact(id: UUID(), name: ""))
                )
                return .none
                
            case let .destination(.presented(.addContact(.delegate(.save(contact))))):
                state.contacts.append(contact)
                return .none
                
            case let .destination(.presented(.alert(.confirmDeletion(id: id)))):
                state.contacts.remove(id: id)
                return .none
                
            case .destination:
                return .none
                
            case let .didTapDeleteButton(id: id):
                state.destination = .alert(
                    AlertState {
                        TextState("Are you sure?")
                    } actions: {
                        ButtonState(role: .destructive, action: .confirmDeletion(id: id)) {
                            TextState("Delete")
                        }
                    }
                )
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
            ContactDetailPageReducer()
        }
    }
    
    
    struct Destination: Reducer {
        enum State: Equatable {
            case addContact(ContactReducer.State)
            case alert(AlertState<ContactsReducer.Action.Alert>)
        }
        
        enum Action {
            case addContact(ContactReducer.Action)
            case alert(ContactsReducer.Action.Alert)
        }
        
        var body: some ReducerOf<Self> {
            Scope(state: /State.addContact, action: /Action.addContact) {
                ContactReducer()
            }
        }
    }
}
