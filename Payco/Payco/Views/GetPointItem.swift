//
//  GetPointItem.swift
//  Payco
//
//  Created by Yumin Chu on 2023/08/28.
//

import SwiftUI

struct GetPointItem: View {
  private let data: GetPoint
  private let action: () -> Void
  private let index: Int
  
  init(data: GetPoint, index: Int, action: @escaping () -> Void) {
    self.data = data
    self.index = index
    self.action = action
  }
  
  var body: some View {
    VStack(alignment: .center, spacing: 20) {
      VStack(alignment: .leading, spacing: 20) {
        VStack(alignment: .leading, spacing: 5) {
          if data.topCaption.isEmpty == false {
            topCaptionText
          }
          titleText
        }
        HStack(alignment: .top) {
          VStack {
            bodyText
            Spacer()
          }
          Spacer()
          bigImage
        }
      }
      redButton
    }
    .tag(index)
    .padding(.horizontal, 20)
    .padding(.top, 30)
    .padding(.bottom, 20)
    .frame(width: UIScreen.main.bounds.width - 40)
    .background {
      RoundedRectangle(cornerRadius: 20)
        .fill(Color("gray_EAEAEA"))
    }
  }
}

struct GetPointItem_Previews: PreviewProvider {
  static var previews: some View {
    GetPointItem(
      data: GetPoint(
        topCaption: "알고 계셨나요?",
        title: "PAYCO 포인트로\n해외결제도 된다는 사실",
        contents: "해외 호텔 & 항공 예약 시\n할인은 기본,\n현지화 출금까지 가능해요",
        imageName: "network",
        buttonTitle: "자세히 보기"
      ), index: 0
    ) {
      print("tapped")
    }
    .frame(height: 380)
    .previewLayout(.sizeThatFits)
  }
}

extension GetPointItem {
  var topCaptionText: some View {
    Text(data.topCaption)
      .font(.caption)
      .fontWeight(.semibold)
      .foregroundColor(.gray)
  }
  
  var titleText: some View {
    Text(data.title)
      .font(.title3)
      .fontWeight(.semibold)
  }
  
  var bodyText: some View {
    Text(data.contents)
      .font(.subheadline)
      .fontWeight(.light)
  }
  
  var bigImage: some View {
    Image(systemName: data.imageName)
      .resizable()
      .scaledToFit()
      .frame(width: 150, height: 150)
      .foregroundColor(.red)
  }
  
  var redButton: some View {
    Button {
      action()
    } label: {
      HStack(spacing: 10) {
        Text(data.buttonTitle)
        Image(systemName: "chevron.right")
          .font(.body)
      }
      .foregroundColor(.white)
      .padding(20)
      .frame(maxWidth: .infinity)
      .background(Color.red)
      .cornerRadius(15)
      .contentShape(RoundedRectangle(cornerRadius: 15))
    }
  }
}
