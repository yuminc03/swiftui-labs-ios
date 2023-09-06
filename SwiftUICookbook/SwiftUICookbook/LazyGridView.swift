//
//  LazyGridView.swift
//  SwiftUICookbook
//
//  Created by Yumin Chu on 2023/09/06.
//

import SwiftUI

struct LazyGridView: View {
  let items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
  let columns = [
    GridItem(.flexible()),
    GridItem(.flexible()),
    GridItem(.flexible())
  ]
  
  var body: some View {
    LazyVGrid(columns: columns, spacing: 20) {
      ForEach(items, id: \.self) { item in
        Text(item)
          .frame(maxWidth: .infinity)
          .frame(height: 100)
          .background(.blue)
          .foregroundColor(.white)
          .cornerRadius(10)
      }
    }
    .padding()
  }
}

struct LazyGridView_Previews: PreviewProvider {
  static var previews: some View {
    LazyGridView()
  }
}
