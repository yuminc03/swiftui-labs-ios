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
    var selectedTabIndex = 0
    let tabItems = TabItem.allCases
    var worldClockRow: IdentifiedArrayOf<WorldClockItem> = []
  }
  
  enum Action {
    case didTapTabItem
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .didTapTabItem:
        return .none
      }
    }
  }
}

struct WorldClockView: View {
  
  private let store: StoreOf<WorldClockCore>
  @ObservedObject private var viewStore: ViewStoreOf<WorldClockCore>
  
  init(store: StoreOf<WorldClockCore>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: { $0 })
  }
  
  var body: some View {
    NavigationStack {
      ZStack {
        Color.black
          .ignoresSafeArea()
        
        List {
          ForEach(viewStore.state.worldClockRow) { item in
            WorldClockRow(worldClockItem: item)
              .background(.clear)
          }
        }
        .listStyle(.plain)
        .listRowBackground(Color.clear)
        .scrollContentBackground(.hidden)
      }
      .navigationTitle(Text("세계 시계"))
      .foregroundColor(.white)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            print("plus button tapped")
          } label: {
            Image(systemName: "plus")
          }
        }
        ToolbarItem(placement: .navigationBarLeading) {
          Button("편집") {
            print("편집 button tapped")
          }
        }
      }
      .foregroundColor(.orange)
    }
  }
}

struct WorldClockView_Previews: PreviewProvider {
  static var previews: some View {
    WorldClockView(store: Store(initialState: WorldClockCore.State()) {
      WorldClockCore()
    })
  }
}

extension WorldClockView {
  
}
