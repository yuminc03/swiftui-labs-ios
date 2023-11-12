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
    @PresentationState var destination: Destination.State?
    var path = StackState<DetailCore.State>()
  }
  
  enum Action {
    case didTapAlertButton
    case didTapPushButton
    case didTapModalButton
    case didTapClearButton
    case destination(PresentationAction<Destination.Action>)
    case path(StackAction<DetailCore.State, DetailCore.Action>)
    
    enum Alert {
      case confirm
    }
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .didTapAlertButton:
        state.destination = .alert(
          AlertState(title: {
            TextState("Are you sure?")
          }, actions: {
            ButtonState(role: .cancel, action: .confirm) {
              TextState("닫기")
            }
          })
        )
        return .none
        
      case .didTapPushButton:
        return .none
        
      case .didTapModalButton:
        state.destination = .modal(.init())
        return .none
        
      case .didTapClearButton:
        state.alertNumber = 0
        state.modalNumber = 0
        state.pushNumber = 0
        return .none
        
      case .destination(.presented(.alert(.confirm))):
        state.alertNumber += 1
        return .none
        
      case .destination(.presented(.modal(.delegate(.increase)))):
        state.modalNumber += 1
        return .none
        
      case .destination:
        return .none
        
      case let .path(.popFrom(id: id)):
        guard let score = state.path[id: id]?.content.score else {
          return .none
        }
        
        state.pushNumber += score
        return .none
        
      case .path:
        return .none
      }
    }
    .ifLet(\.$destination, action: /Action.destination) {
      Destination()
    }
    .forEach(\.path, action: /Action.path) {
      DetailCore()
    }
  }
}

extension FruitScoreCore {
  struct Destination: Reducer {
    enum State: Equatable {
      case alert(AlertState<FruitScoreCore.Action.Alert>)
      case modal(ModalCore.State)
    }
    
    enum Action: Equatable {
      case alert(FruitScoreCore.Action.Alert)
      case modal(ModalCore.Action)
    }
    
    var body: some ReducerOf<Self> {
      Scope(state: /State.modal, action: /Action.modal) {
        ModalCore()
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
    NavigationStackStore(store.scope(state: \.path, action: { .path($0) })) {
      VStack {
        List {
          ForEach(viewStore.scores) { score in
            NavigationLink(state: DetailCore.State(content: score)) {
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
    } destination: {
      DetailView(store: $0)
    }
    .alert(
      store: store.scope(
        state: \.$destination, action: { .destination($0) }
      ),
      state: /FruitScoreCore.Destination.State.alert,
      action: FruitScoreCore.Destination.Action.alert
    )
    .sheet(
      store: store.scope(
        state: \.$destination, action: { .destination($0) }
      ),
      state: /FruitScoreCore.Destination.State.modal, 
      action: FruitScoreCore.Destination.Action.modal
    ) { store in
      ModalView(store: store)
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
