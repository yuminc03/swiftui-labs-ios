//
//  SearchView.swift
//  Settings
//
//  Created by Yumin Chu on 2023/08/20.
//

import SwiftUI

struct SearchView: View {
    
    @State private var searchText = ""
    
    var body: some View {
        HStack(spacing: 10) {
            searchImage
            textField
        }
        .background(Color("gray_D8D8D8"))
        .cornerRadius(15)
    }
}

struct SearchTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            SearchView()
        }
        .ignoresSafeArea()
    }
}

extension SearchView {
    var searchImage: some View {
        Image(systemName: "magnifyingglass")
            .resizable()
            .foregroundColor(.gray)
            .frame(width: 20, height: 20)
            .padding([.vertical, .leading])
    }
    
    var textField: some View {
        TextField(text: $searchText) {
            Text("검색")
                .foregroundColor(.gray)
                .font(.title2)
        }
    }
}
