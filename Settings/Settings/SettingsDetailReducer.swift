//
//  SettingsDetailReducer.swift
//  Settings
//
//  Created by Yumin Chu on 2023/08/20.
//

import Foundation

import ComposableArchitecture

struct SettingsDetailReducer: Reducer {
    
    struct State: Equatable {
        var item: SettingItem
    }
    
    enum Action: Equatable {
        case didTapBackButton
        case delegate(Delegate)
        enum Delegate: Equatable {
            case updateSearchBarText(String)
        }
    }
    @Dependency(\.dismiss) var dismiss
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapBackButton:
                return .run { [title = state.item.title] send in
                    await send(.delegate(.updateSearchBarText(title)))
                    await dismiss()
                }
                
            case .delegate:
                return .none
            }
        }
    }
}
