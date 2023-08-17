//
//  AddContactView.swift
//  ContactsTCATutorials
//
//  Created by Yumin Chu on 2023/08/13.
//

import SwiftUI

import ComposableArchitecture

struct AddContactView: View {
    let store: StoreOf<AddContactFeature>
    @ObservedObject var viewStore: ViewStoreOf<AddContactFeature>
    
    init(store: StoreOf<AddContactFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }
    
    var body: some View {
        Form {
            TextField(
                "Name",
                text: viewStore.binding(get: \.contact.name, send: { .setName($0) })
            )
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

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddContactView(
                store: Store(
                    initialState: AddContactFeature.State(
                        contact: Contact(id: UUID(), name: "Blob")
                    ),
                    reducer: {
                        AddContactFeature()
                    }
                )
            )
        }
    }
}
