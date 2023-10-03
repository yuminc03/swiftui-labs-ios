//
//  ContactsFeatureView.swift
//  ContactsTCATutorials
//
//  Created by Yumin Chu on 2023/08/13.
//

import SwiftUI

import ComposableArchitecture

struct ContactsFeatureView: View {
    let store: StoreOf<ContactsFeature>
    @ObservedObject var viewStore: ViewStoreOf<ContactsFeature>
    
    init() {
        self.store = Store(initialState: ContactsFeature.State(
            contacts: [
                Contact(id: UUID(), name: "Blob"),
                Contact(id: UUID(), name: "Blob Jr"),
                Contact(id: UUID(), name: "Blob Sr"),
            ]
        )) {
            ContactsFeature()
        }
        self.viewStore = ViewStore(store, observe: { $0 })
    }
    
    var body: some View {
        NavigationStackStore(store.scope(state: \.path, action: { .path($0) })) {
            List {
                ForEach(viewStore.state.contacts) { contact in
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
        } destination: { store in
            ContactDetailView(store: store)
        }
        .sheet(
            store: store.scope(
                state: \.$destination,
                action: { .destination($0) }
            ),
            state: /ContactsFeature.Destination.State.addContact,
            action: ContactsFeature.Destination.Action.addContact
        ) { addContactStore in
            NavigationStack {
                AddContactView(store: addContactStore)
            }
        }
        .alert(
            store: store.scope(state: \.$destination, action: { .destination($0) }),
            state: /ContactsFeature.Destination.State.alert,
            action: ContactsFeature.Destination.Action.alert
        )
    }
}

struct ContactsFeatureView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsFeatureView()
    }
}
