//
//  MultipleDestinationsView.swift
//  TCAExample
//
//  Created by Yumin Chu on 2023/10/26.
//

import SwiftUI

import ComposableArchitecture

struct MultipleDestinationsCore: Reducer {
  struct State: Equatable {
    @PresentationState var destination: Destination.State?
  }
  
  enum Action {
    case destination(PresentationAction<Destination.Action>)
    case didTapDrillButton
    case didTapPopoverButton
    case didTapSheetButton
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .destination:
        return .none
        
      case .didTapDrillButton:
        state.destination = .drillDown(CounterCore.State())
        return .none
        
      case .didTapPopoverButton:
        state.destination = .popover(CounterCore.State())
        return .none
        
      case .didTapSheetButton:
        state.destination = .sheet(CounterCore.State())
        return .none
      }
    }
    .ifLet(\.$destination, action: /Action.destination) {
      Destination()
    }
  }
  
  struct Destination: Reducer {
    enum State: Equatable {
      case drillDown(CounterCore.State)
      case popover(CounterCore.State)
      case sheet(CounterCore.State)
    }
    
    enum Action {
      case dillDown(CounterCore.Action)
      case popover(CounterCore.Action)
      case sheet(CounterCore.Action)
    }
    
    var body: some ReducerOf<Self> {
      Scope(state: /State.drillDown, action: /Action.dillDown) {
        CounterCore()
      }
      Scope(state: /State.popover, action: /Action.popover) {
        CounterCore()
      }
      Scope(state: /State.sheet, action: /Action.sheet) {
        CounterCore()
      }
    }
  }
}

struct MultipleDestinationsView: View {
  private let store: StoreOf<MultipleDestinationsCore>
  
  init() {
    self.store = .init(initialState: MultipleDestinationsCore.State()) {
      MultipleDestinationsCore()
    }
  }
  
  var body: some View {
    Form {
      Button("Show drill-down") {
        store.send(.didTapDrillButton)
      }
      
      Button("Show popover") {
        store.send(.didTapPopoverButton)
      }
      
      Button("Show sheet") {
        store.send(.didTapSheetButton)
      }
    }
    .navigationDestination(
      store: store.scope(
        state: \.$destination, action: { .destination($0) }
      ),
      state: /MultipleDestinationsCore.Destination.State.drillDown,
      action: MultipleDestinationsCore.Destination.Action.dillDown
    ) { store in
      CounterView(store: store)
    }
    .popover(
      store: store.scope(
        state: \.$destination, action: { .destination($0) }
      ),
      state: /MultipleDestinationsCore.Destination.State.popover,
      action: MultipleDestinationsCore.Destination.Action.popover
    ) { store in
      CounterView(store: store)
    }
    .sheet(
      store: store.scope(
        state: \.$destination, action: { .destination($0) }
      ),
      state: /MultipleDestinationsCore.Destination.State.sheet,
      action: MultipleDestinationsCore.Destination.Action.sheet
    ) { store in
      CounterView(store: store)
    }
    .navigationTitle("Multiple Destinations")
  }
}

struct MultipleDestinationsView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      MultipleDestinationsView()
    }
  }
}
