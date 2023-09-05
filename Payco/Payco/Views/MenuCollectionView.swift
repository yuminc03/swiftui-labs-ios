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
    VStack(alignment: .center, spacing: 20) {
      ForEach(0 ..< 2) { index in
        HStack(alignment: .center, spacing: 20) {
          ForEach(4 * index ..< 4 * index + 4) { i in
            menuItem(
              imageName: data[i].imageName,
              imageColor: data[i].iconColor,
              title: data[i].title
            )
          }
        }
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
    .frame(
      width: (UIScreen.main.bounds.width - 100) / 4,
      height: 70
    )
  }
}
