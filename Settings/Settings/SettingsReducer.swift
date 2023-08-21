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
                imageName: "bluetooth",
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
        var searchBarText = ""
        @PresentationState var airplainModeAlert: AlertState<Action.Alert>?
        var path = StackState<SettingsDetailReducer.State>()
    }
    
    enum Action {
        case didTapSettingCell(String)
        case didTapAirplainModeSwitch(Bool)
        case airplainModeAlert(PresentationAction<Alert>)
        case path(StackAction<SettingsDetailReducer.State, SettingsDetailReducer.Action>)
        enum Alert: Equatable {
            case switchAirplainModeAlert(Bool)
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .didTapSettingCell(title):
                return .none
                
            case let .didTapAirplainModeSwitch(isOn):
                state.airplainModeAlert = AlertState {
                    TextState("Toggle 상태를 바꿀까요?")
                } actions: {
                    ButtonState(role: .destructive, action: .switchAirplainModeAlert(isOn)) {
                        TextState("Change")
                    }
                }
                return .none
                
            case let .airplainModeAlert(.presented(.switchAirplainModeAlert(isOn))):
                state.isAirplainSwitchOn = isOn
                return .none
                
            case .airplainModeAlert:
                return .none
                
            case let .path(.element(id: id, action: .didTapBackButton)):
//                guard let index = state.settings.index(id: id) else {
//                    return .none
//                }
//
//                state.searchBarText = state.settings[index].title
                return .none
                
            case .path:
                return .none
            }
        }
        .ifLet(\.$airplainModeAlert, action: /Action.airplainModeAlert)
        .forEach(\.path, action: /Action.path) {
            SettingsDetailReducer()
        }
    }
}
