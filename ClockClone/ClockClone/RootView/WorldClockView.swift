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
    setNavigaitonBarColors()
  }
  
  var body: some View {
    NavigationStack {
      ZStack {
        Color.black
          .ignoresSafeArea()
        
        List {
          ForEach(0 ..< viewStore.state.worldClockRow.count) { index in
            WorldClockRow(
              worldClockItem: viewStore.state.worldClockRow[index],
              isFirstRow: index == 0
            )
          }
          .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .listStyle(.plain)
        .padding(.horizontal, 20)
      }
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
      .navigationTitle("세계 시계")
    }
  }
}

struct WorldClockView_Previews: PreviewProvider {
  static var previews: some View {
    WorldClockView(store: Store(initialState: WorldClockCore.State(
      worldClockRow: [
        WorldClockItem(id: UUID(), parallax: "오늘, +0시간", cityName: "서울", isAM: false, time: "7:22")
      ]
    )) {
      WorldClockCore()
    })
  }
}

extension WorldClockView {
  
  private func setNavigaitonBarColors() {
    UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    UINavigationBar.appearance().barTintColor = UIColor.black
  }
}
