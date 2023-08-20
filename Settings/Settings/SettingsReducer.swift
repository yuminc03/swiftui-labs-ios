//
//  SettingsReducer.swift
//  Settings
//
//  Created by Yumin Chu on 2023/08/20.
//

import Foundation

import ComposableArchitecture

struct SettingsReducer: Reducer {
    
    struct State: Equatable {
        var settings: IdentifiedArrayOf<SettingsModel> = []
        var isAirplainSwitchOn = false
    }
    
    enum Action {
        case didTapSettingCell(String)
        case didTapAirplainModeSwitch(Bool)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .didTapSettingCell(title):
                
                return .none
                
            case let .didTapAirplainModeSwitch(isOn):
                state.isAirplainSwitchOn = isOn
                return .none
            }
        }
    }
}
