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
    var cities = CityGroup.dummy
    var editMode: EditMode = .inactive
    @PresentationState var addCity: SelectCityCore.State?
  }
  
  enum Action {
    case onDeleteClock(at: IndexSet)
    case onMoveClock(from: IndexSet, to: Int)
    case didTapAddButton
    case addCity(PresentationAction<SelectCityCore.Action>)
    case bindEditMode(EditMode)
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
        
      case let .addCity(.presented(.delegate(.save(group, index)))):
        guard let cities = state.cities[id: group.id]?.cities else {
          return .none
        }
        
        let koreaDateString = Date().toString(
          format: "yyyy-MM-dd'T'HH:mm:ss",
          id: "Asia/Seoul"
        )
        let koreaDate = koreaDateString.toDate(
          format: "yyyy-MM-dd'T'HH:mm:ss",
          id: "Asia/Seoul"
        ) ?? Date()
        let id = CityTime.randomID
        let randomDateString = Date().toString(
          format: "yyyy-MM-dd'T'HH:mm:ss",
          id: id
        )
        let randomDate = randomDateString.toDate(
          format: "yyyy-MM-dd'T'HH:mm:ss",
          id: id
        ) ?? Date()
        let parallax: Int
        switch koreaDate.compare(randomDate) {
        case .orderedDescending:
          parallax = Int(randomDate.timeIntervalSince(koreaDate) / 86400)

        case .orderedAscending:
          parallax = Int(koreaDate.timeIntervalSince(randomDate) / 86400)
          
        case .orderedSame:
          parallax = 0
        }
        
        print("korean: \(koreaDateString)")
        print("random: \(randomDateString)")
        print("korean: \(koreaDate)")
        print("random: \(randomDate)")

        state.worldClocks.append(
          WorldClockItem(
            parallax: "오늘, \(koreaDate > randomDate ? "+" : "-")\(parallax)시간",
            cityName: cities[index].name.components(separatedBy: ", ").last ?? "",
            time: Date().toString(id: id)
          )
        )
        state.cities[id: group.id]?.cities.remove(at: index)
        return .none
        
      case .addCity:
        return .none
        
      case let .bindEditMode(editMode):
        state.editMode = editMode
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
  @Environment(\.editMode) private var editMode
  
  init() {
    self.store = Store(initialState: WorldClockCore.State()) {
      WorldClockCore()
        ._printChanges()
    }
    self.viewStore = ViewStore(store, observe: { $0 })
  }
  
  var body: some View {
    VStack {
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
              isEditMode: viewStore.editMode == .active
            )
          }
          .onDelete { store.send(.onDeleteClock(at: $0)) }
          .onMove { store.send(.onMoveClock(from: $0, to: $1)) }
          .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
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
    .environment(
      \.editMode,
       viewStore.binding(get: \.editMode, send: { .bindEditMode($0) })
    )
    .sheet(store: store.scope(state: \.$addCity, action: { .addCity($0) })) { store in
      SelectCityView(store: store)
    }
  }
}

struct WorldClockView_Previews: PreviewProvider {
  static var previews: some View {
    WorldClockView()
      .previewLayout(.sizeThatFits)
  }
}
