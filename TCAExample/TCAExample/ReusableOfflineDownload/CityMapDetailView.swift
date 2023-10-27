//
//  CityMapDetailView.swift
//  TCAExample
//
//  Created by Yumin Chu on 2023/10/27.
//

import SwiftUI

import ComposableArchitecture

struct CityMapDetailView: View {
  private let store: StoreOf<CityMapRowCore>
  @ObservedObject private var viewStore: ViewStoreOf<CityMapRowCore>
  
  init(store: StoreOf<CityMapRowCore>) {
    self.store = store
    self.viewStore = .init(store, observe: { $0 })
  }
  
  var body: some View {
    VStack(spacing: 32) {
      Text(viewStore.download.blurb)
      
      HStack {
        switch viewStore.downloadMode {
        case .notDownloaded:
          Text("Download for offline viewing")
          
        case .downloaded:
          Text("Downloaded")
          
        default:
          Text("Downloading \(Int(100 * viewStore.downloadComponent.mode.progress))%")
        }
        
        Spacer()
        
        DownloadComponentView(store: store.scope(
          state: \.downloadComponent,
          action: { .downloadComponent($0) }
        ))
      }
      Spacer()
    }
    .navigationTitle(viewStore.download.title)
    .padding()
  }
}

//struct CityMapDetailView_Previews: PreviewProvider {
//  static var previews: some View {
//    CityMapDetailView()
//  }
//}
