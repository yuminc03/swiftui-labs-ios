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
        var setting: SettingsModel
    }
    
    enum Action {
        case didTapBackButton
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        return .none
    }
}
