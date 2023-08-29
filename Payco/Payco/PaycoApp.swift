//
//  PaycoApp.swift
//  Payco
//
//  Created by Yumin Chu on 2023/08/26.
//

import SwiftUI

import ComposableArchitecture

@main
struct PaycoApp: App {
  private let store: StoreOf<ContentCore>
  @ObservedObject private var viewStore: ViewStoreOf<ContentCore>
  
  init() {
    self.store = .init(initialState: .init(), reducer: {
      ContentCore()
    })
    self.viewStore = ViewStore(self.store, observe: { $0 })
  }
  
  var body: some Scene {
    WindowGroup {
      ZStack {
        tabBar
        findFeatureBanner
          .padding(.bottom, 50)
      }
    }
  }
}

extension PaycoApp {
  
  var tabBar: some View {
    TabView(selection: viewStore.binding(get: \.selectedIndex, send: .didTapTabItem)) {
      Color.red
        .ignoresSafeArea(edges: .top)
        .tabItem {
          Image(systemName: "percent")
          Text("혜택")
        }
        .tag(0)
      
      ContentView()
        .tabItem {
          Image(systemName: "p.circle.fill")
          Text("포인트")
        }
        .tag(1)
      
      Color.yellow
        .ignoresSafeArea(edges: .top)
        .tabItem {
          Image(systemName: "barcode.viewfinder")
          Text("결제")
        }
        .tag(2)
      
      Color.blue
        .ignoresSafeArea(edges: .top)
        .tabItem {
          Image(systemName: "chart.bar.fill")
          Text("금융")
        }
        .tag(3)
      
      Color.purple
        .ignoresSafeArea(edges: .top)
        .tabItem {
          Image(systemName: "ellipsis")
          Text("전체")
        }
        .tag(4)
    }
    .tint(.red)
  }
  
  var findFeatureBanner: some View {
    VStack {
      Spacer()
      if viewStore.isFindFeatureBannerHidden == false {
        FindFeatureBannerView {
          store.send(.didTapFindFeatureBannerXButton)
        }
      }
    }
  }
}
