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
        enum Delegate: Equatable {
            
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            return .none
        }
    }
}
