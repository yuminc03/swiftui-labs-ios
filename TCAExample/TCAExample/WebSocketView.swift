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
    var connectState = ConnectState.disconnected
    var messageToSend = ""
    var receivedMessages = [String]()
    
    enum ConnectState: String {
      case connected
      case connecting
      case disconnected
      
      var buttonTitle: String {
        switch self {
        case .connected:
          return "Disconnect"
          
        case .connecting:
          return "Connecting..."
          
        case .disconnected:
          return "Connect"
        }
      }
      
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
  }
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case .didTapConnectButton:
      switch state.connectState {
      case .connected, .connecting:
        state.connectState = .disconnected
//        return .cancel(id: )
        
      case .disconnected:
        break
      }
      return .none
      
    case let .didChangedMessageToSend(message):
      return .none
      
    case .didTapSendButton:
      return .none
    }
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
          Button(viewStore.connectState.buttonTitle) {
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
