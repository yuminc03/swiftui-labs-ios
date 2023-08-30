//
//  NowPaycoScrollView.swift
//  Payco
//
//  Created by Yumin Chu on 2023/08/28.
//

import SwiftUI

struct NowPaycoScrollView: View {
  private let leftImageName: String
  private let title: String
  private let images: [NowPaycoItem]
  
  init(leftImageName: String, title: String, images: [NowPaycoItem]) {
    self.leftImageName = leftImageName
    self.title = title
    self.images = images
  }
  
  var body: some View {
    VStack(spacing: 40) {
      titleView
        .padding(.leading, 40)
      imageGridView
    }
    .padding(.vertical, 30)
    .background {
      Color.clear
        .overlay {
          RoundedRectangle(cornerRadius: 20)
            .fill(Color("gray_EAEAEA"))
            .padding(.horizontal, 20)
        }
    }
  }
}

struct NowPaycoItem_Previews: PreviewProvider {
  static var previews: some View {
    NowPaycoScrollView(leftImageName: "camera.viewfinder", title: "지금 페이코는", images: NowPaycoItem.dummy)
      .previewLayout(.sizeThatFits)
  }
}

extension NowPaycoScrollView {
  
  var titleView: some View {
    HStack(spacing: 5) {
      Image(systemName: leftImageName)
        .foregroundColor(.pink)
        .font(.title2)
      Text(title)
        .font(.title3)
        .fontWeight(.semibold)
      Spacer()
    }
  }
  
  var imageGridView: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      LazyHGrid(rows: [GridItem(.flexible(), spacing: 10)]) {
        ForEach(0 ..< images.count) { index in
          if index == 0 {
            NowPaycoImageItem(imageName: images[index].imageName)
              .padding(.leading, 40)
          } else if index == images.count - 1 {
            NowPaycoImageItem(imageName: images[index].imageName)
              .padding(.trailing, 40)
          } else {
            NowPaycoImageItem(imageName: images[index].imageName)
          }
        }
      }
    }
  }
}
