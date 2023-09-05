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
        .padding(.leading, 20)
      imageGridView
        .padding(.horizontal, -20)
    }
    .padding(.vertical, 30)
    .background {
      Color.clear
        .overlay {
          RoundedRectangle(cornerRadius: 20)
            .fill(Color("gray_EAEAEA"))
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
      HStack(alignment: .center, spacing: 10) {
        clearItem
        ForEach(0 ..< images.count) { index in
          roundedImage(imageName: images[index].imageName)
        }
        clearItem
      }
    }
  }
  
  var clearItem: some View {
    RoundedRectangle(cornerRadius: 20)
      .fill(.clear)
      .frame(width: 30, height: 120)
  }
  
  private func roundedImage(imageName: String) -> some View {
    Image(imageName)
      .resizable()
      .roundedRectangleImage()
  }
}
