//
//  NowPaycoImageItem.swift
//  Payco
//
//  Created by Yumin Chu on 2023/08/28.
//

import SwiftUI

struct NowPaycoImageItem: View { // modifier로 바꿔보기
  
  private let imageName: String
  
  init(imageName: String) {
    self.imageName = imageName
  }
  
  var body: some View {
    Image(imageName)
      .resizable()
      .scaledToFill()
      .frame(width: 120, height: 120)
      .cornerRadius(20)
  }
}

struct NowPaycoImageItem_Previews: PreviewProvider {
  static var previews: some View {
    NowPaycoImageItem(imageName: NowPaycoItem.dummy[0].imageName)
      .previewLayout(.sizeThatFits)
  }
}
