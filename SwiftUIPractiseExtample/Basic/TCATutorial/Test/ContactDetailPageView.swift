//
//  ContactDetailPageView.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/21.
//

import SwiftUI

import ComposableArchitecture

struct ContactDetailPageView: View {
    private let store: StoreOf<ContactDetailPageReducer>
    @ObservedObject private var viewStore: ViewStoreOf<ContactDetailPageReducer>
    
    init(store: StoreOf<ContactDetailPageReducer>) {
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

struct ContactDetailPageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ContactDetailPageView(
                store: Store(
                    initialState: ContactDetailPageReducer.State(
                        contact: Contact(id: UUID(), name: "Yumin")
                    )
                ) {
                    ContactDetailPageReducer()
                }
            )
        }
    }
}
