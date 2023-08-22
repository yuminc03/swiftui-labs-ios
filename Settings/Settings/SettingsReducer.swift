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
        let section1 = SettingItem.section1
        let section2 = SettingItem.section2
        let section3 = SettingItem.section3
        var toggleState = ToggleReducer.State()
        var searchBarText = ""
        @PresentationState var destination: Destination.State?
        var path = StackState<SettingsDetailReducer.State>()
    }
    
    enum Action {
        case toggleAction(ToggleReducer.Action)
        case destination(PresentationAction<Destination.Action>)
        case path(StackAction<SettingsDetailReducer.State, SettingsDetailReducer.Action>)
        case didChangeSearchBarText(String)
        enum Alert: Equatable {
            case toggle
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .didChangeSearchBarText(text):
                state.searchBarText = text
                return .none
                
            case .destination(.presented(.airplainModeAlert(.toggle))):
                state.toggleState.isOn.toggle()
                return .none
                
            case .destination:
                return .none
                
            case let .path(.element(id: _, action: .delegate(.updateSearchBarText(text)))):
                state.searchBarText = text
                return .none
                
            case .path:
                return .none
                
            case .toggleAction(.delegate(.isToggleOn)):
                state.destination = .airplainModeAlert(AlertState{
                    TextState("Toggle 상태를 바꿀까요?")
                } actions: {
                    ButtonState(role: .destructive, action: .toggle ) {
                        TextState("Change")
                    }
                })
                return .none
                
            case .toggleAction:
                return .none
            }
        }
        .ifLet(\.$destination, action: /Action.destination) {
            Destination()
        }
        .forEach(\.path, action: /Action.path) {
            SettingsDetailReducer()
        }
        Scope(state: \.toggleState, action: /Action.toggleAction) {
            ToggleReducer()
                ._printChanges()
        }
    }
    
    struct Destination: Reducer {
        enum State: Equatable {
            case updateSearchBarText(SettingsDetailReducer.State)
            case airplainModeAlert(AlertState<SettingsReducer.Action.Alert>)
        }
        
        enum Action: Equatable {
            case updateSearchBarText(SettingsDetailReducer.Action)
            case airplainModeAlert(SettingsReducer.Action.Alert)
        }
        
        var body: some ReducerOf<Self> {
            Scope(state: /State.updateSearchBarText, action: /Action.updateSearchBarText) {
                SettingsDetailReducer()
            }
        }
    }
}
