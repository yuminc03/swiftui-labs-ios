//
//  KeyPadApp.swift
//  KeyPad
//
//  Created by Yumin Chu on 2023/08/19.
//

import SwiftUI

import ComposableArchitecture

@main
struct KeyPadApp: App {
    
    private let store: StoreOf<KeyPadReducer>
    @ObservedObject private var viewStore: ViewStoreOf<KeyPadReducer>
    
    init() {
        self.store = Store(initialState: KeyPadReducer.State()) {
            KeyPadReducer()
        }
        self.viewStore = ViewStore(store, observe: { $0 })
    }
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: viewStore.binding(
                get: \.selectedTab,
                send: KeyPadReducer.Action.didTapTabItem
            )) {
                Text("First")
                    .tabItem {
                        Image(systemName: "star.fill")
                        Text("즐겨찾기")
                    }
                    .tag(0)
                Text("Second")
                    .tabItem {
                        Image(systemName: "clock.fill")
                        Text("최근 통화")
                    }
                    .tag(1)
                Text("Third")
                    .tabItem {
                        Image(systemName: "person.crop.circle.fill")
                        Text("연락처")
                    }
                    .tag(2)
                ContentView()
                .tabItem {
                    Image(systemName: "circle.grid.3x3.fill")
                    Text("키패드")
                }
                .tag(3)
                Text("Fifth")
                    .tabItem {
                        Image(systemName: "recordingtape")
                        Text("음성 사서함")
                    }
                    .tag(4)
            }
        }
    }
}
