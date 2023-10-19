//
//  AlertAndConfirmationDialogView.swift
//  TCAExample
//
//  Created by Yumin Chu on 2023/10/19.
//

import SwiftUI

import ComposableArchitecture

struct AlertAndConfirmationDialogCore: Reducer {
  struct State: Equatable {
    var count = 0
    @PresentationState var alert: AlertState<Action.Alert>?
    @PresentationState var actionSheet: ConfirmationDialogState<Action.ActionSheet>?
  }
  
  enum Action {
    case didTapAlertButton
    case didTapConfirmationButton
    case alert(PresentationAction<Alert>)
    case actionSheet(PresentationAction<ActionSheet>)
    
    enum Alert {
      case didTapIncreaseButton
    }
    
    enum ActionSheet {
      case didTapDecreaseButton
      case didTapIncreaseButton
    }
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .didTapAlertButton:
        state.alert = AlertState {
          TextState("Alert")
        } actions: {
          ButtonState(role: .cancel) {
            TextState("Cancel")
          }
          ButtonState(action: .didTapIncreaseButton) {
            TextState("Increment")
          }
        } message: {
          TextState("This is an alert.🙂")
        }
        return .none
        
      case .didTapConfirmationButton:
        state.actionSheet = ConfirmationDialogState {
          TextState("ConfirmationDialog")
        } actions: {
          ButtonState(action: .didTapIncreaseButton) {
            TextState("Increment")
          }
          ButtonState(action: .didTapDecreaseButton) {
            TextState("Decrement")
          }
        } message: {
          TextState("This is a confirmation dialog.")
        }
        return .none
        
      case .alert(.presented(.didTapIncreaseButton)):
        state.alert = AlertState {
          TextState("Incremented!🎉")
        }
        state.count += 1
        return .none
        
      case .alert:
        return .none
        
      case .actionSheet(.presented(.didTapDecreaseButton)):
        state.alert = AlertState {
          TextState("Decremented!🔥")
        }
        state.count -= 1
        return .none
        
      case .actionSheet(.presented(.didTapIncreaseButton)):
        state.alert = AlertState {
          TextState("Incremented!🎁")
        }
        state.count += 1
        return .none
        
      case .actionSheet:
        return .none
      }
    }
    .ifLet(\.$alert, action: /Action.alert)
    .ifLet(\.$actionSheet, action: /Action.actionSheet)
  }
}

struct AlertAndConfirmationDialogView: View {
  private let store: StoreOf<AlertAndConfirmationDialogCore>
  @ObservedObject private var viewStore: ViewStoreOf<AlertAndConfirmationDialogCore>
  
  init() {
    self.store = .init(initialState: AlertAndConfirmationDialogCore.State()) {
      AlertAndConfirmationDialogCore()
    }
    self.viewStore = .init(store, observe: { $0 })
  }
  
  var body: some View {
    Form {
      Text("Count: \(viewStore.count)")
      Button("Alert") {
        viewStore.send(.didTapAlertButton)
      }
      Button("Confirmation Dialog") {
        viewStore.send(.didTapConfirmationButton)
      }
    }
    .navigationTitle("Alerts & Dialogs")
    .alert(store: store.scope(state: \.$alert, action: { .alert($0) }))
    .confirmationDialog(store: store.scope(state: \.$actionSheet, action: { .actionSheet($0) }))
  }
}

struct AlertAndConfirmationDialogView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      AlertAndConfirmationDialogView()
    }
  }
}
