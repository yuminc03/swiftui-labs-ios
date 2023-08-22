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
        var isAirplainSwitchOn = false
        var searchBarText = ""
        @PresentationState var destination: Destination.State?
        var path = StackState<SettingsDetailReducer.State>()
    }
    
    enum Action {
        case didTapAirplainModeSwitch(Bool)
        case destination(PresentationAction<Destination.Action>)
        case path(StackAction<SettingsDetailReducer.State, SettingsDetailReducer.Action>)
        case didChangeSearchBarText(String)
        enum Alert: Equatable {
            case switchAirplainModeAlert(Bool)
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .didTapAirplainModeSwitch(isOn):
                state.destination = .airplainModeAlert(.airplainModeAlert(isOn: isOn))
                return .none
                
            case let .destination(.presented(.airplainModeAlert(.switchAirplainModeAlert(isOn)))):
                state.isAirplainSwitchOn = isOn
                return .none
                
            case let .destination(.presented(.updateSearchBarText(.delegate(.updateSearchBarText(text))))):
                print("\(text)")
                return .none
                
            case .destination:
                return .none
                
            case .path:
                return .none
                
            case let .didChangeSearchBarText(text):
                state.searchBarText = text
                return .none
            }
        }
        .ifLet(\.$destination, action: /Action.destination) {
            Destination()
        }
        .forEach(\.path, action: /Action.path) {
            SettingsDetailReducer()
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

extension AlertState where Action == SettingsReducer.Action.Alert {
    static func airplainModeAlert(isOn: Bool) -> Self {
        Self {
            TextState("Toggle 상태를 바꿀까요?")
        } actions: {
            ButtonState(role: .destructive, action: .switchAirplainModeAlert(isOn)) {
                TextState("Change")
            }
        }
    }
}
