//
//  CitiesView.swift
//  TCAExample
//
//  Created by Yumin Chu on 2023/10/27.
//

import SwiftUI

import ComposableArchitecture

struct CitiesCore: Reducer {
  struct State: Equatable {
    var cityMaps: IdentifiedArrayOf<CityMapRowCore.State>
  }
  
  enum Action {
    case cityMaps(id: CityMapRowCore.State.ID, action: CityMapRowCore.Action)
  }
  
  var body: some ReducerOf<Self> {
    EmptyReducer()
      .forEach(\.cityMaps, action: /Action.cityMaps(id:action:)) {
        CityMapRowCore()
      }
  }
}

struct CitiesView: View {
  private let store: StoreOf<CitiesCore>
  
  init() {
    self.store = .init(initialState: CitiesCore.State(cityMaps: .mocks)) {
      CitiesCore()
    }
  }
  
  var body: some View {
    Form {
      ForEachStore(store.scope(
        state: \.cityMaps,
        action: { .cityMaps(id: $0, action: $1)}
      )) { cityMapRowStore in
        CityMapRowView(store: cityMapRowStore)
          .buttonStyle(.borderless)
      }
    }
    .navigationTitle("Offline Downloads")
  }
}

struct CitiesView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      CitiesView()
    }
  }
}
