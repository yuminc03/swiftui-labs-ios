//
//  SearchBarReducer.swift
//  Settings
//
//  Created by Yumin Chu on 2023/08/21.
//

import Foundation

import ComposableArchitecture

struct SearchBarReducer: Reducer {
    struct State: Equatable {
        var searchBarText = "검색"
    }
    
    enum Action {
        case didChangeText(String)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .didChangeText(text):
                state.searchBarText = text
                return .none
            }
        }
    }
}
