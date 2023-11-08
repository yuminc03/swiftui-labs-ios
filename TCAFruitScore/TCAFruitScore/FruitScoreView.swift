//
//  FruitScoreView.swift
//  TCAFruitScore
//
//  Created by Yumin Chu on 2023/10/06.
//

import SwiftUI

import ComposableArchitecture

struct FruitScoreCore: Reducer {
  struct State: Equatable {
    let scores = Score.dummy
    var pushNumber = 0
    var alertNumber = 0
    var modalNumber = 0
//    var path = StackState<>
  }
  
  enum Action {
    case didTapAlertButton
    case didTapPushButton
    case didTapModalButton
    case didTapClearButton
    
    enum Alert {
      case confirm
    }
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .didTapAlertButton:
        return .none
        
      case .didTapPushButton:
        return .none
        
      case .didTapModalButton:
        return .none
        
      case .didTapClearButton:
        return .none
      }
    }
  }
}

struct FruitScoreView: View {
  private let store: StoreOf<FruitScoreCore>
  @ObservedObject private var viewStore: ViewStoreOf<FruitScoreCore>
  
  init() {
    self.store = .init(initialState: FruitScoreCore.State()) {
      FruitScoreCore()
    }
    self.viewStore = .init(store, observe: { $0 })
  }
  
  var body: some View {
    NavigationStack {
      VStack {
        List {
          ForEach(viewStore.scores) { score in
            NavigationLink {
              
            } label: {
              Text(score.name)
            }
          }
        }
        .listStyle(.plain)
        .frame(height: 200)
        HStack(spacing: 10) {
          blueButton(title: "Alert") {
            viewStore.send(.didTapAlertButton)
          }
          blueButton(title: "Modal") {
            viewStore.send(.didTapModalButton)
          }
          blueButton(title: "Clear") {
            viewStore.send(.didTapClearButton)
          }
        }
        VStack(alignment: .leading, spacing: 10) {
          Text("Alert: \(viewStore.alertNumber)")
          Text("Modal: \(viewStore.modalNumber)")
          Text("Push: \(viewStore.pushNumber)")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .font(.title)
        .background(
          RoundedRectangle(cornerRadius: 10)
            .foregroundColor(.gray)
        )
        .padding(.horizontal, 20)
      }
    }
    
  }
}

extension FruitScoreCore {
  struct Destination: Reducer {
    enum State: Equatable {
      case alert(AlertState<FruitScoreCore.Action.Alert>)
    }
    
    enum Action: Equatable {
      case alert(FruitScoreCore.Action.Alert)
    }
    
    var body: some ReducerOf<Self> {
      Scope(state: /State.alert, action: /Action.alert) {
        
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    FruitScoreView()
  }
}

extension FruitScoreView {
  
  func blueButton(title: String, action: @escaping () -> Void) -> some View {
    Button(title) {
      action()
    }
    .padding(20)
    .background(Color.blue)
    .foregroundColor(.white)
    .cornerRadius(10)
  }
}
