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
    LazyVGrid(
      columns: [
        GridItem(.flexible(), spacing: 20, alignment: .center),
        GridItem(.flexible(), spacing: 20, alignment: .center),
        GridItem(.flexible(), spacing: 20, alignment: .center),
        GridItem(.flexible(), spacing: 20, alignment: .center)
      ],
      spacing: 20
    ) {
      ForEach(data) { item in
        menuItem(
          imageName: item.imageName,
          imageColor: item.iconColor,
          title: item.title
        )
      }
    }
  }
}

struct MenuCollectionView_Previews: PreviewProvider {
  static var previews: some View {
    MenuCollectionView(data: MenuCollectionItem.dummy)
      .previewLayout(.sizeThatFits)
  }
}

extension MenuCollectionView {
  
  private func menuItem(
    imageName: String,
    imageColor: Color,
    title: String
  ) -> some View {
    VStack(spacing: 10) {
      Image(systemName: imageName)
        .font(.largeTitle)
        .foregroundColor(imageColor)
      Text(title)
        .font(.caption)
    }
  }
}
