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
        let settings: IdentifiedArrayOf<SettingItem> = [
            .airPods,
            .airplane,
            .wifi,
            .bluetooth,
            .celluar,
            .hotspot,
            .vpn,
            .notification,
            .soundAndHaptic,
            .focusMode,
            .screenTime
        ]
        var isAirplainSwitchOn = false
        var searchBar = SearchBarReducer.State()
        @PresentationState var destination: Destination.State?
        var path = StackState<SettingsDetailReducer.State>()
    }
    
    enum Action {
        case didTapAirplainModeSwitch(Bool)
        case destination(PresentationAction<Destination.Action>)
        case path(StackAction<SettingsDetailReducer.State, SettingsDetailReducer.Action>)
        case searchBar(SearchBarReducer.Action)
        enum Alert: Equatable {
            case switchAirplainModeAlert(Bool)
        }
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.searchBar, action: /Action.searchBar, child: {
            SearchBarReducer()
        })
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
                
            case .searchBar:
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
