//
//  SelectCityView.swift
//  ClockClone
//
//  Created by Yumin Chu on 2023/09/04.
//

import SwiftUI

import ComposableArchitecture

struct SelectCityCore: Reducer {
  struct State: Equatable {
    var cities: IdentifiedArrayOf<City>
    var searchText = ""
  }
  
  enum Action {
    case didTapCancelButton
    case didChangeSearchText(String)
    case didTapRow(City)
    case delegate(Delegate)
    
    enum Delegate: Equatable {
      case save(City)
    }
  }
  
  @Dependency(\.dismiss) var dismiss
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case .didTapCancelButton:
      return .run { _ in
        await dismiss()
      }
      
    case let .didChangeSearchText(text):
      state.searchText = text
      return .none
      
    case let .didTapRow(city):
      state.cities.remove(id: city.id)
      return .run { send in
        await send(.delegate(.save(city)))
        await dismiss()
      }
      
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
          titleView
          searchView
        }
        .padding(.horizontal, 20)
        List {
          ForEach(viewStore.cities) { city in
            SearchCityRow(city: city)
              .onTapGesture {
                store.send(.didTapRow(city))
              }
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
    SelectCityView(store: Store(initialState: SelectCityCore.State(cities: City.dummy)) {
      SelectCityCore()
    })
  }
}

extension SelectCityView {
  
  var titleView: some View {
    Text("도시 선택")
      .font(.subheadline)
      .padding(.top, 10)
  }
  
  var searchView: some View {
    HStack(spacing: 10) {
      textField
      Button("취소") {
        store.send(.didTapCancelButton)
      }
      .foregroundColor(.orange)
    }
    .foregroundColor(Color("gray_C7C7C7"))
  }
  
  var textField: some View {
    HStack(alignment: .center, spacing: 2) {
      Image(systemName: "magnifyingglass")
      TextField(
        "Search",
        text: viewStore.binding(
          get: \.searchText,
          send: { .didChangeSearchText($0) }
        ),
        prompt: Text("검색")
      )
      .frame(height: 40)
      .background(Color("gray_424242"))
    }
    .padding(.horizontal, 5)
    .background {
      RoundedRectangle(cornerRadius: 10)
        .fill(Color("gray_424242"))
    }
    .cornerRadius(10)
  }
}
