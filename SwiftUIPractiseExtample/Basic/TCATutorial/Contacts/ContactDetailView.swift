//
//  ContactDetailView.swift
//  ContactsTCATutorials
//
//  Created by Yumin Chu on 2023/08/14.
//

import SwiftUI

import ComposableArchitecture

struct ContactDetailView: View {
    let store: StoreOf<ContactDetailFeature>
    @ObservedObject var viewStore: ViewStoreOf<ContactDetailFeature>
    
    init(store: StoreOf<ContactDetailFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }
    
    var body: some View {
        Form {
            Button("Delete") {
                viewStore.send(.didTapDeleteButton)
            }
        }
        .navigationTitle(Text(viewStore.contact.name))
        .alert(store: store.scope(state: \.$alert, action: { .alert($0) }))
    }
}

struct ContactDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ContactDetailView(
                store: Store(initialState: ContactDetailFeature.State(
                    contact: Contact(
                        id: UUID(),
                        name: "Blob"
                    )
                )) {
                    ContactDetailFeature()
                }
            )
        }
    }
}
