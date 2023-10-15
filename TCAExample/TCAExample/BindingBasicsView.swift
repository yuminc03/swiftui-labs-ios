//
//  BindingBasicsView.swift
//  TCAExample
//
//  Created by Yumin Chu on 2023/10/14.
//

import SwiftUI

import ComposableArchitecture

struct BindingBasicsCore: Reducer {
  struct State: Equatable {
    var text = ""
    var isSwitchOn = false
    var sliderValue = 5.0
    var stepCount = 10
  }
  
  enum Action {
    case didChangedText(String)
    case didChangedSliderValue(Double)
    case didChangedStepCount(Int)
    case didChangedSwitchOn(Bool)
  }
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case let .didChangedText(text):
      state.text = text
      return .none
      
    case let .didChangedSliderValue(value):
      state.sliderValue = value
      return .none
      
    case let .didChangedStepCount(count):
      state.sliderValue = .minimum(state.sliderValue, Double(count))
      state.stepCount = count
      return .none
      
    case let .didChangedSwitchOn(isOn):
      state.isSwitchOn = isOn
      return .none
    }
  }
}

struct BindingBasicsView: View {
  private let store: StoreOf<BindingBasicsCore>
  @ObservedObject private var viewStore: ViewStoreOf<BindingBasicsCore>
  
  init() {
    let store = Store(initialState: BindingBasicsCore.State()) {
      BindingBasicsCore()
    }
    self.store = store
    self.viewStore = ViewStore(store, observe: { $0 })
  }
  
  var body: some View {
    Form {
      HStack {
        TextField(
          "type here",
          text: viewStore.binding(
            get: \.text,
            send: { .didChangedText($0) }
          )
        )
        .autocorrectionDisabled(true)
        .foregroundStyle(viewStore.isSwitchOn ? .secondary : .primary)
        Text(alternate(viewStore.text))
      }
      .disabled(viewStore.isSwitchOn)
      
      Toggle(
        "Disabled other controls",
        isOn: viewStore.binding(
          get: \.isSwitchOn,
          send: { .didChangedSwitchOn($0) }
        )
      )
      
      Stepper(
        "Max slider value: \(Int(viewStore.stepCount))",
        value: viewStore.binding(
          get: \.stepCount,
          send: { .didChangedStepCount($0) }),
        in: 0 ... 100
      )
      .disabled(viewStore.isSwitchOn)
      
      HStack {
        Text("Slider value: \(Int(viewStore.sliderValue))")
        Slider(
          value: viewStore.binding(
            get: \.sliderValue,
            send: { .didChangedSliderValue($0) }),
          in: 0 ... Double(viewStore.stepCount)
        )
        .tint(.accentColor)
      }
      .disabled(viewStore.isSwitchOn)
    }
    .monospacedDigit()
    .navigationTitle("Bindings basics")
  }
  
  private func alternate(_ text: String) -> String {
    text.enumerated().map { index, char in
      index.isMultiple(of: 2) ? char.uppercased() : char.lowercased()
    }
    .joined()
  }
}

struct BindingBasicsView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      BindingBasicsView()
    }
  }
}
