//
//  WorldClockCore.swift
//  ClockClone
//
//  Created by Yumin Chu on 2023/09/03.
//

import SwiftUI

import ComposableArchitecture

struct WorldClockCore: Reducer {
  struct State: Equatable {
    var worldClocks = WorldClockItem.dummy
    var cities = City.dummy
    @PresentationState var addCity: SelectCityCore.State?
  }
  @Environment(\.editMode) var editMode
  
  enum Action {
    case onDeleteClock(at: IndexSet)
    case onMoveClock(from: IndexSet, to: Int)
    case didTapAddButton
    case addCity(PresentationAction<SelectCityCore.Action>)
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case let .onDeleteClock(at: indexSet):
        state.worldClocks.remove(atOffsets: indexSet)
        return .none
        
      case let .onMoveClock(from: indexSet, to: index):
        state.worldClocks.move(fromOffsets: indexSet, toOffset: index)
        return .none
        
      case .didTapAddButton:
        state.addCity = SelectCityCore.State(cities: state.cities)
        return .none
        
      case let .addCity(.presented(.delegate(.save(city)))):
        state.cities.remove(id: city.id)
        state.worldClocks.append(
          WorldClockItem(
            parallax: "오늘, +0시간",
            cityName: city.name.components(separatedBy: ", ").last ?? "",
            time: CityTime.randomTime
          )
        )
        return .none
        
      case .addCity:
        return .none
      }
    }
    .ifLet(\.$addCity, action: /Action.addCity) {
      SelectCityCore()
    }
  }
}

struct WorldClockView: View {
  private let store: StoreOf<WorldClockCore>
  @ObservedObject private var viewStore: ViewStoreOf<WorldClockCore>
  
  init() {
    self.store = Store(initialState: WorldClockCore.State()) {
      WorldClockCore()
    }
    self.viewStore = ViewStore(store, observe: { $0 })
  }
  
  var body: some View {
    NavigationStack {
      ZStack {
        Color.black
          .ignoresSafeArea()
        if viewStore.worldClocks.isEmpty {
          Text("세계 시계 없음")
            .font(.largeTitle)
            .foregroundColor(Color("gray_424242"))
        } else {
          List {
            ForEach(viewStore.worldClocks) { worldClock in
              WorldClockRow(
                worldClockItem: worldClock,
                isFirstRow: worldClock == viewStore.worldClocks[0],
                isEditMode: false
              )
            }
            .onDelete { store.send(.onDeleteClock(at: $0)) }
            .onMove { store.send(.onMoveClock(from: $0, to: $1)) }
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowSeparator(.hidden)
          }
          .listStyle(.plain)
        }
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            store.send(.didTapAddButton)
          } label: {
            Image(systemName: "plus")
          }
        }
        if viewStore.worldClocks.isEmpty == false {
          ToolbarItem(placement: .navigationBarLeading) {
            EditButton()
          }
        }
      }
      .foregroundColor(.orange)
      .navigationTitle("세계 시계")
    }
    .sheet(store: store.scope(state: \.$addCity, action: { .addCity($0) })) { store in
      SelectCityView(store: store)
    }
  }
}

struct WorldClockView_Previews: PreviewProvider {
  static var previews: some View {
    WorldClockView()
  }
}
