//
//  ContactDetailPageReducer.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/21.
//

import Foundation

import ComposableArchitecture

struct ContactDetailPageReducer: Reducer {
    struct State: Equatable {
        let contact: Contact
        @PresentationState var alert: AlertState<Action.Alert>?
    }
    
    enum Action {
        case alert(PresentationAction<Alert>)
        case delegate(Delegate)
        case didTapDeleteButton
        enum Alert {
            case confirmDeletion
        }
        enum Delegate {
            case confirmDeletion
        }
    }
    
    @Dependency(\.dismiss) var dismiss
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .alert(.presented(.confirmDeletion)):
                return .run { send in
                    await send(.delegate(.confirmDeletion))
                    await dismiss()
                }
                
            case .alert:
                return .none
                
            case .delegate:
                return .none
                
            case .didTapDeleteButton:
                state.alert = .confirmDeletion
                return .none
            }
        }
        .ifLet(\.$alert, action: /Action.alert)
    }
}

extension AlertState where Action == ContactDetailPageReducer.Action.Alert {
    
    static let confirmDeletion = Self {
        TextState("Are you sure?")
    } actions: {
        ButtonState(role: .destructive, action: .confirmDeletion) {
            TextState("Delete")
        }
    }
}
