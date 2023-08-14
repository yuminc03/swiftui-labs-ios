//
//  KeyPadReducer.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/14.
//

import Foundation

import ComposableArchitecture

struct KeyPadReducer: Reducer {
    
    struct State: Equatable {
        var numberString = ""
    }
    
    enum Action {
        case didTapNumberButton(String)
        case didTapDeleteButton
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .didTapNumberButton(number):
            state.numberString += number
            return .none
            
        case .didTapDeleteButton:
            guard state.numberString.isEmpty == false else {
                return .none
            }
            
            let endIndex = state.numberString.index(before: state.numberString.endIndex)
            state.numberString = String(state.numberString[state.numberString.startIndex ..< endIndex])
            return .none
        }
    }
}
