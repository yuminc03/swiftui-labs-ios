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
            guard state.numberString.isEmpty == false else {
                state.numberString += number
                return .none
            }
            
            let count = state.numberString.components(separatedBy: "-").map { $0.count }.reduce(0) { $0 + $1 }
            
            switch count {
            case 2:
                state.numberString += "-"
                
            case 3:
                state.numberString = state.numberString.components(separatedBy: "-").map { $0 }.reduce("") { $0 + $1 }
                state.numberString += "-"
                
            case 5:
                state.numberString += "-"
                
            case 8:
                guard let dashIndex = state.numberString.lastIndex(of: "-") else {
                    state.numberString += number
                    return .none
                }
                
                let endIndex = state.numberString.index(before: state.numberString.endIndex)
                let nextIndex = state.numberString.index(after: dashIndex)
                let leadingNumbers = String(state.numberString[state.numberString.startIndex ..< dashIndex])
                let trailingNumbers = String(state.numberString[nextIndex ..< endIndex])
                state.numberString = leadingNumbers
                state.numberString += trailingNumbers
                state.numberString += "-"
                state.numberString += number
                
            case 11:
                state.numberString += "-"
                
            default:
                break
            }
            
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
