//
//  BindingFormView.swift
//  TCAExample
//
//  Created by Yumin Chu on 2023/10/15.
//

import SwiftUI

import ComposableArchitecture

struct BindingFormCore: Reducer {
  struct State: Equatable {
    @BindingState var text = ""
    @BindingState var isSwitchOn = false
    @BindingState var sliderValue = 5.0
    @BindingState var stepCount = 10
  }
  
  enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case didTapResetButton
  }
  
  var body: some Reducer<State, Action> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding(\.$stepCount):
        state.sliderValue = .minimum(state.sliderValue, Double(state.stepCount))
        return .none
        
      case .binding:
        return .none
        
      case .didTapResetButton:
        state = State()
        return .none
      }
    }
  }
}

struct BindingFormView: View {
  private let store: StoreOf<BindingFormCore>
  @ObservedObject private var viewStore: ViewStoreOf<BindingFormCore>
  
  init() {
    let store = Store(initialState: BindingFormCore.State()) {
      BindingFormCore()
    }
    self.store = store
    self.viewStore = ViewStore(store, observe: { $0 })
  }
  
  var body: some View {
    Form {
      HStack {
        TextField("text here", text: viewStore.$text)
          .autocorrectionDisabled(true)
          .foregroundStyle(viewStore.isSwitchOn ? .secondary : .primary)
        Text(alternate(viewStore.text))
      }
      .disabled(viewStore.isSwitchOn)
      
      Toggle(
        "Disabled other controls",
        isOn: viewStore.$isSwitchOn
      )
      
      Stepper(
        "Max slider value: \(viewStore.stepCount)",
        value: viewStore.$stepCount,
        in: 0 ... 100
      )
      .disabled(viewStore.isSwitchOn)
      
      HStack {
        Text("Slider Value: \(Int(viewStore.sliderValue))")
        Slider(
          value: viewStore.$sliderValue,
          in: 0 ... Double(viewStore.stepCount)
        )
        .tint(.accentColor)
      }
      .disabled(viewStore.isSwitchOn)
      
      Button("Reset") {
        viewStore.send(.didTapResetButton)
      }
      .tint(.red)
    }
    .monospacedDigit()
    .navigationTitle("Binding form")
  }
  
  private func alternate(_ text: String) -> String {
    text.enumerated().map { index, char in
      index.isMultiple(of: 2) ? char.uppercased() : char.lowercased()
    }
    .joined()
  }
}

struct BindingFormView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      BindingFormView()
    }
  }
}
