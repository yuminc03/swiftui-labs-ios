//
//  ToggleView.swift
//  Settings
//
//  Created by Yumin Chu on 2023/08/22.
//

import SwiftUI

import ComposableArchitecture

struct ToggleView: View {
    private let store: StoreOf<ToggleReducer>
    @ObservedObject private var viewStore: ViewStoreOf<ToggleReducer>
    
    init(store: StoreOf<ToggleReducer>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }
    
    var body: some View {
        Toggle(isOn: viewStore.binding(get: \.isOn, send: .didTapToggle)) {
            SettingsRow(setting: .airplane)
        }
    }
}

struct ToggleView_Previews: PreviewProvider {
    static var previews: some View {
        ToggleView(store: Store(initialState: ToggleReducer.State()) {
            ToggleReducer()
        })
        .previewLayout(.sizeThatFits)
    }
}
