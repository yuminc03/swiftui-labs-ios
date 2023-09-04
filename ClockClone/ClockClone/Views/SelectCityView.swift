//
//  SelectCityView.swift
//  ClockClone
//
//  Created by LS-NOTE-00106 on 2023/09/04.
//

import SwiftUI

import ComposableArchitecture

struct SelectCityCore: Reducer {
  struct State: Equatable {
    var searchText = ""
    let cities = City.dummy
    let city: City
  }
  
  enum Action {
    case didChangeSearchText(String)
    case delegate(Delegate)
    
    enum Delegate: Equatable {
      case save(String)
    }
  }
  
  @Dependency(\.dismiss) var dismiss
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    return .none
  }
}
struct SelectCityView: View {
  private let store: StoreOf<SelectCityCore>
  @ObservedObject private var viewStore: ViewStoreOf<SelectCityCore>
  
  init(store: StoreOf<SelectCityCore>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: { $0 })
  }
  
  var body: some View {
    NavigationStack {
      VStack(spacing: 20) {
        List {
          ForEach(viewStore.cities) { city in
            SearchCityRow(city: city)
          }
          .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .listStyle(.plain)
      }
      .searchable(
        text: viewStore.binding(
          get: \.searchText,
          send: { .didChangeSearchText($0) }
        ),
        placement: .toolbar,
        prompt: "검색"
      )
      .navigationTitle("도시 선택")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

struct SelectCityView_Previews: PreviewProvider {
  static var previews: some View {
    SelectCityView(store: Store(initialState: SelectCityCore.State(city: City(name: ""))) {
      SelectCityCore()
    })
  }
}
