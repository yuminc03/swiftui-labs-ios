//
//  FindFeatureBannerView.swift
//  Payco
//
//  Created by Yumin Chu on 2023/08/29.
//

import SwiftUI

struct FindFeatureBannerView: View {
  
  private let xButtonAction: () -> Void
  
  init(xButtonAction: @escaping () -> Void) {
    self.xButtonAction = xButtonAction
  }
  
  var body: some View {
    ZStack {
      HStack(spacing: 5) {
        Text("이 기능 어딨지?")
          .foregroundColor(.white)
          .font(.headline)
        Text("검색해서 바로 찾기")
          .foregroundColor(.yellow)
          .font(.headline)
        Text("🔍")
          .font(.headline)
      }
      .padding(20)
      .frame(maxWidth: .infinity)
      .background(Color.black)
      Rectangle()
        .fill(.black)
        .frame(width: 20, height: 20)
        .rotationEffect(Angle(degrees: 45))
        .offset(x: UIScreen.main.bounds.width / 2 - 40, y: 25)
      HStack {
        Spacer()
        Button {
          xButtonAction()
        } label: {
          Image(systemName: "xmark")
            .font(.title3)
            .foregroundColor(.gray)
        }
      }
      .padding(.horizontal, 20)
    }
  }
}

struct FindFeatureBannerView_Previews: PreviewProvider {
  static var previews: some View {
    FindFeatureBannerView {
      print("x button action")
    }
    .previewLayout(.sizeThatFits)
  }
}
