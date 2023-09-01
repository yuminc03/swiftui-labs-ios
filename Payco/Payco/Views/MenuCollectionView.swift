//
//  MenuCollectionView.swift
//  Payco
//
//  Created by Yumin Chu on 2023/08/30.
//

import SwiftUI

struct MenuCollectionView: View {
  
  private let data: [MenuCollectionItem]
  
  init(data: [MenuCollectionItem]) {
    self.data = data
  }
  
  var body: some View {
    LazyVGrid( // lazy 지우기
      columns: [
        GridItem(.flexible(), spacing: 20, alignment: .center),
        GridItem(.flexible(), spacing: 20, alignment: .center),
        GridItem(.flexible(), spacing: 20, alignment: .center),
        GridItem(.flexible(), spacing: 20, alignment: .center)
      ],
      spacing: 20
    ) {
      ForEach(data) { item in
        VStack(spacing: 10) {
          Image(systemName: item.imageName)
            .font(.largeTitle)
            .foregroundColor(item.iconColor)
          Text(item.title)
            .font(.caption)
        }
      }
    }
    .padding(.horizontal, 20)
    .padding(.vertical, 10)
  }
}

struct MenuCollectionView_Previews: PreviewProvider {
  static var previews: some View {
    MenuCollectionView(data: MenuCollectionItem.dummy)
      .previewLayout(.sizeThatFits)
  }
}
