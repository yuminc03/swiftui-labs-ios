//
//  SettingsDetailView.swift
//  Settings
//
//  Created by Yumin Chu on 2023/08/20.
//

import SwiftUI

import ComposableArchitecture

struct SettingsDetailView: View {
    
    private let store: StoreOf<SettingsDetailReducer>
    @ObservedObject private var viewStore: ViewStoreOf<SettingsDetailReducer>
    
    init(store: StoreOf<SettingsDetailReducer>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }
    
    var body: some View {
        VStack {
            Text("")
                .font(.largeTitle)
            Button("뒤로가기") {
                viewStore.send(.didTapBackButton)
            }
        }
    }
}

struct SettingsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsDetailView(store: Store(
                initialState: SettingsDetailReducer.State(
                    setting: SettingsModel(
                        id: UUID(),
                        title: ""
                    )
                )
        ) {
            SettingsDetailReducer()
        })
    }
}
