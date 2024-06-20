//
//  NoticeDetailView.swift
//  TCACoordinatorExample
//
//  Created by LS-NOTE-00106 on 6/20/24.
//

import SwiftUI

import ComposableArchitecture

@Reducer
struct NoticeDetailCore: Reducer {
  struct State: Equatable {
    let id = UUID()
  }
  
  enum Action: Equatable {
    case tapPopButton
    case tapGotoClinicTab
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .tapPopButton:
        break
        
      case .tapGotoClinicTab:
        break
      }
      
      return .none
    }
  }
}

struct NoticeDetailView: View {
  private let store: StoreOf<NoticeDetailCore>
  @ObservedObject private var viewStore: ViewStoreOf<NoticeDetailCore>
  
  init(store: StoreOf<NoticeDetailCore>) {
    self.store = store
    self.viewStore = .init(self.store, observe: { $0 })
  }

  var body: some View {
    VStack(spacing: 30) {
      BasicButton(title: "Pop") {
        store.send(.tapPopButton)
      }
      BasicButton(title: "go to Clinic Tab") {
        store.send(.tapGotoClinicTab)
      }
    }
  }
}

#Preview {
  NoticeDetailView(store: .init(initialState: NoticeDetailCore.State()) {
    NoticeDetailCore()
  })
}
