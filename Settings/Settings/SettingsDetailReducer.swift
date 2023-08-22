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
        var setting: SettingItem
    }
    
    enum Action: Equatable {
        case didTapBackButton
        case delegate(Delegate)
        enum Delegate: Equatable {
            case updateSearchBarText(String)
        }
    }
    @Dependency(\.dismiss) var dismiss
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .didTapBackButton:
            return .run { [title = state.setting.title] send in
                await send(.delegate(.updateSearchBarText(title)))
                await dismiss()
            }
            
        case .delegate:
            return .none
        }
    }
}
