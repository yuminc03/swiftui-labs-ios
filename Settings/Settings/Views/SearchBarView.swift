//
//  SearchBarView.swift
//  Settings
//
//  Created by Yumin Chu on 2023/08/20.
//

import SwiftUI

import ComposableArchitecture

struct SearchBarView: View {
    
    private let store: StoreOf<SearchBarReducer>
    @ObservedObject private var viewStore: ViewStoreOf<SearchBarReducer>
    
    init(store: StoreOf<SearchBarReducer>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }
    
    var body: some View {
        Label {
            searchText
            Spacer()
        } icon: {
            searchImage
        }
        .background(Color("gray_D8D8D8"))
        .cornerRadius(15)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            SearchBarView(
                store: Store(
                    initialState: SearchBarReducer.State(searchBarText: "검색")) {
                SearchBarReducer()
            })
        }
        .ignoresSafeArea()
    }
}

extension SearchBarView {
    var searchImage: some View {
        Image(systemName: "magnifyingglass")
            .resizable()
            .foregroundColor(.gray)
            .frame(width: 20, height: 20)
            .padding([.vertical, .leading])
    }
    
    var searchText: some View {
        Text(viewStore.searchBarText)
            .foregroundColor(.gray)
            .font(.title2)
    }
}
