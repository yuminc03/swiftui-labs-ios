//
//  ToggleReducer.swift
//  Settings
//
//  Created by Yumin Chu on 2023/08/22.
//

import Foundation

import ComposableArchitecture

struct ToggleReducer: Reducer {
    
    struct State: Equatable {
        var isOn = false
    }
    
    enum Action: Equatable {
        case didTapToggle
        case delegate(Delegate)
    }
    
    enum Delegate: Equatable {
        case isToggleOn
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapToggle:
                return .send(.delegate(.isToggleOn))
                
            case .delegate:
                return .none
            }
        }
    }
}
