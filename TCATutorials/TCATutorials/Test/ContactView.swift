//
//  ContactView.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/21.
//

import SwiftUI

import ComposableArchitecture

struct ContactView: View {
    
    private let store: StoreOf<ContactReducer>
    @ObservedObject private var viewStore: ViewStoreOf<ContactReducer>
    
    init(store: StoreOf<ContactReducer>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField(
                    "Name",
                    text: viewStore.binding(
                        get: \.contact.name,
                        send: { .setName($0) }
                    )
                )
                Button("Save") {
                    viewStore.send(.didTapSaveButton)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        viewStore.send(.didTapCancelButton)
                    }
                }
            }
        }
    }
}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView(store: Store(
            initialState: ContactReducer.State(
                contact: Contact(
                    id: UUID(),
                    name: "Yumin"
                )
            )) {
                ContactReducer()
            }
        )
    }
}
