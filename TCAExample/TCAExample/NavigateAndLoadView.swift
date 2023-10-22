//
//  NavigateAndLoadView.swift
//  TCAExample
//
//  Created by Yumin Chu on 2023/10/23.
//

import SwiftUI

import ComposableArchitecture

struct NavigateAndLoadCore: Reducer {
  struct State: Equatable {
    
  }
  
  enum Action {
    
  }
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    return .none
  }
}

struct NavigateAndLoadView: View {
  private let store: StoreOf<NavigateAndLoadCore>
  @ObservedObject private var viewStore: ViewStoreOf<NavigateAndLoadCore>
  
  init() {
    self.store = .init(initialState: NavigateAndLoadCore.State()) {
      NavigateAndLoadCore()
    }
    self.viewStore = .init(store, observe: { $0 })
  }
  
  var body: some View {
    Form {
      NavigationLink {
        
      } label: {
        
      }
    }
    .navigationTitle("Navigate and load")
  }
}

struct NavigateAndLoadView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      NavigateAndLoadView()
    }
  }
}
