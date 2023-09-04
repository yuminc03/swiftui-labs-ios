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
    let cities = City.dummy
    var searchText = ""
    var selectedCity: City?
  }
  
  enum Action {
    case didChangeSearchText(String)
    case didTapRow
    case delegate(Delegate)
    
    enum Delegate: Equatable {
      case save(String)
    }
  }
  
  @Dependency(\.dismiss) var dismiss
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case let .didChangeSearchText(text):
      return .none
      
    case .didTapRow:
      return .none
      
    case .delegate:
      return .none
    }
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
        VStack(alignment: .center, spacing: 20) {
          Text("도시 선택")
            .font(.body)
        }
        .ignoresSafeArea()
        List {
          ForEach(viewStore.cities) { city in
            SearchCityRow(city: city)
          }
          .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .listStyle(.plain)
      }
      .toolbar(.hidden, for: .navigationBar)
    }
  }
}

struct SelectCityView_Previews: PreviewProvider {
  static var previews: some View {
    SelectCityView(store: Store(initialState: SelectCityCore.State()) {
      SelectCityCore()
    })
  }
}
