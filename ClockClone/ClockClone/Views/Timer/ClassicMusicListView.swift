//
//  ClassicMusicListView.swift
//  ClockClone
//
//  Created by Yumin Chu on 2023/09/08.
//

import SwiftUI

import ComposableArchitecture

struct ClassicMusicListCore: Reducer {
  struct State: Equatable {
    let classicMusics = City.classicDummy
  }
  
  struct Action {
    
  }
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    return .none
  }
}


struct ClassicMusicListView: View {
  private let store: StoreOf<ClassicMusicListCore>
  private var viewStore: ViewStoreOf<ClassicMusicListCore>
  
  init() {
    self.store = Store(initialState: ClassicMusicListCore.State()) {
      ClassicMusicListCore()
    }
    self.viewStore = ViewStore(store, observe: { $0 })
  }
  
  var body: some View {
    NavigationStack {
      List {
        ForEach(viewStore.classicMusics) { music in
          Text(music.name)
        }
      }
      .navigationTitle("클래식")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

struct ClassicMusicListView_Previews: PreviewProvider {
  static var previews: some View {
    ClassicMusicListView()
  }
}
