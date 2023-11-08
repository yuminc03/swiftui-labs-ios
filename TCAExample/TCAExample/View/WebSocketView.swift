//
//  WebSocketView.swift
//  TCAExample
//
//  Created by Yumin Chu on 2023/10/25.
//

import SwiftUI

import ComposableArchitecture

struct WebSocketCore: Reducer {
  struct State: Equatable {
    @PresentationState var alert: AlertState<Action.Alert>?
    var connectState = ConnectState.disconnected
    var messageToSend = ""
    var receivedMessages = [String]()
    var buttonTitle: String {
      if connectState == .connected {
        return "Disconnect"
      } else if connectState == .disconnected {
        return "Connect"
      } else {
        return "Connecting..."
      }
    }
    
    enum ConnectState: String {
      case connected
      case connecting
      case disconnected
      
      var buttonColor: Color {
        switch self {
        case .connected:
          return .red
          
        case .connecting:
          return .green
          
        case .disconnected:
          return .green
        }
      }
    }
  }
  
  enum Action {
    case didTapConnectButton
    case didChangedMessageToSend(String)
    case didTapSendButton
    case webSocket(WebSocketClient.Action)
    case receivedSocketMessage(TaskResult<WebSocketClient.Message>)
    case sendResponse(didSucceed: Bool)
    case alert(PresentationAction<Alert>)
    
    enum Alert: Equatable { }
  }
  
  @Dependency(\.continuousClock) var clock
  @Dependency(\.webSocket) var webSocket
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .didTapConnectButton:
        switch state.connectState {
        case .connected, .connecting:
          state.connectState = .disconnected
          return .cancel(id: WebSocketClient.ID())
          
        case .disconnected:
          state.connectState = .connecting
          return .run { send in
            let actions = await webSocket.open(
              WebSocketClient.ID(),
              URL(string: "wss://echo.websocket.events")!,
              []
            )
            await withThrowingTaskGroup(of: Void.self) { group in
              for await action in actions {
                group.addTask {
                  await send(.webSocket(action))
                }
                switch action {
                case .didOpen:
                  group.addTask {
                    while !Task.isCancelled {
                      try await clock.sleep(for: .seconds(10))
                      try? await webSocket.sendPing(WebSocketClient.ID())
                    }
                  }
                  group.addTask {
                    for await result in try await webSocket.receive(WebSocketClient.ID()) {
                      await send(.receivedSocketMessage(result))
                    }
                  }
                
                case .didClose:
                  return
                }
              }
            }
          }
          .cancellable(id: WebSocketClient.ID())
        }
        
      case let .didChangedMessageToSend(message):
        state.messageToSend = message
        return .none
        
      case let .receivedSocketMessage(.success(message)):
        if case let .string(string) = message {
          state.receivedMessages.append(string)
        }
        return .none
        
      case .receivedSocketMessage(.failure):
        return .none
        
      case .didTapSendButton:
        let messageToSend = state.messageToSend
        state.messageToSend = ""
        return .run { send in
          try await webSocket.send(WebSocketClient.ID(), .string(messageToSend))
          await send(.sendResponse(didSucceed: true))
        } catch: { _, send in
          await send(.sendResponse(didSucceed: false))
        }
        .cancellable(id: WebSocketClient.ID())
        
      case .sendResponse(didSucceed: true):
        return .none
        
      case .sendResponse(didSucceed: false):
        state.alert = AlertState {
          TextState("Could not send socket message. Connect to the server first, and try again.")
        }
        return .none
        
      case .webSocket(.didClose):
        state.connectState = .disconnected
        return .cancel(id: WebSocketClient.ID())
        
      case .webSocket(.didOpen):
        state.connectState = .connected
        state.receivedMessages.removeAll()
        return .none
        
      case .alert:
        return .none
      }
    }
    .ifLet(\.$alert, action: /Action.alert)
  }
}

struct WebSocketView: View {
  private let store: StoreOf<WebSocketCore>
  @ObservedObject private var viewStore: ViewStoreOf<WebSocketCore>
  
  init() {
    self.store = .init(initialState: WebSocketCore.State()) {
      WebSocketCore()
    }
    self.viewStore = .init(store, observe: { $0 })
  }
  
  var body: some View {
    Form {
      Section {
        VStack(alignment: .leading) {
          Button(viewStore.buttonTitle) {
            viewStore.send(.didTapConnectButton)
          }
          .buttonStyle(.bordered)
          .tint(viewStore.connectState.buttonColor)
          
          HStack {
            TextField(
              "Type message here",
              text: viewStore.binding(
                get: \.messageToSend,
                send: { .didChangedMessageToSend($0) }
              )
            )
            .textFieldStyle(.roundedBorder)
            
            Button("Send") {
              viewStore.send(.didTapSendButton)
            }
            .buttonStyle(.borderless)
          }
        }
      }
      
      Section {
        Text("Status: \(viewStore.connectState.rawValue)")
          .foregroundColor(.secondary)
        
        Text(viewStore.receivedMessages.reversed().joined(separator: "\n"))
      } header: {
        Text("Received messages")
      }
    }
    .alert(store: store.scope(state: \.$alert, action: { .alert($0) }))
    .navigationTitle("Web Socket")
  }
}

struct WebSocketView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      WebSocketView()
    }
  }
}
