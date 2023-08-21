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
        let settings: IdentifiedArrayOf<SettingsModel> = [
            SettingsModel(
                id: UUID(),
                imageName: "airpodspro",
                iconColor: .gray,
                title: "유민의 AirPads Pro 2",
                rightText: ""
            ),
            SettingsModel(
                id: UUID(),
                imageName: "airplane",
                iconColor: .orange,
                title: "에어플레인 모드",
                rightText: ""
            ),
            SettingsModel(
                id: UUID(),
                imageName: "wifi",
                iconColor: .blue,
                title: "Wi-Fi",
                rightText: "LS_DEV"
            ),
            SettingsModel(
                id: UUID(),
                imageName: "wave.3.right",
                iconColor: .blue,
                title: "Bluetooth",
                rightText: "켬"
            ),
            SettingsModel(
                id: UUID(),
                imageName: "antenna.radiowaves.left.and.right",
                iconColor: .green,
                title: "셀룰러",
                rightText: ""
            ),
            SettingsModel(
                id: UUID(),
                imageName: "personalhotspot",
                iconColor: .green,
                title: "개인용 핫스팟",
                rightText: "끔"
            ),
            SettingsModel(
                id: UUID(),
                imageName: "lock.fill",
                iconColor: .blue,
                title: "VPN",
                rightText: "연결 안 됨"
            ),
            SettingsModel(
                id: UUID(),
                imageName: "bell.badge",
                iconColor: .red,
                title: "알림",
                rightText: ""
            ),
            SettingsModel(
                id: UUID(),
                imageName: "speaker.wave.3.fill",
                iconColor: .pink,
                title: "사운드 및 햅틱",
                rightText: ""
            ),
            SettingsModel(
                id: UUID(),
                imageName: "moon.fill",
                iconColor: .indigo,
                title: "집중 모드",
                rightText: ""
            ),
            SettingsModel(
                id: UUID(),
                imageName: "hourglass",
                iconColor: .indigo,
                title: "스크린 타임",
                rightText: ""
            )
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
        Reduce { state, action in
            switch action {
            case let .didTapAirplainModeSwitch(isOn):
                state.destination = .airplainModeAlert(.airplainModeAlert(isOn: isOn))
                return .none
                
            case let .destination(.presented(.airplainModeAlert(.switchAirplainModeAlert(isOn)))):
                state.isAirplainSwitchOn = isOn
                return .none
                
            case let .destination(.presented(.updateSearchBarText(.delegate(.updateSearchBarText(text))))):
                return .none
                
            case .destination:
                return .none

            case .path:
                return .none
                
            case .destination(.presented):
                return .none
            }
        }
        Scope(state: \.searchBar, action: /Action.searchBar, child: {
            SearchBarReducer()
        })
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
