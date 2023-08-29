//
//  BrandOfMonthView.swift
//  Payco
//
//  Created by Yumin Chu on 2023/08/28.
//

import SwiftUI

struct BrandOfMonthView: View {
  @State private var xOffset: CGFloat = 0
  private let topTitle: String
  private let bottomTitle: String
  private let rightButtonTitle: String
  private let imageNames: [BrandOfMonthItem]
  private let action: () -> Void
  
  init(topTitle: String, bottomTitle: String, rightButtonTitle: String, imageNames: [BrandOfMonthItem], action: @escaping () -> Void) {
    self.topTitle = topTitle
    self.bottomTitle = bottomTitle
    self.rightButtonTitle = rightButtonTitle
    self.imageNames = imageNames
    self.action = action
  }
  
  var body: some View {
    VStack(spacing: 40) {
      HStack {
        VStack(alignment: .leading) {
          topTitleText
          bottomTitleText
        }
        Spacer()
        rightButton
      }
      .padding(.horizontal, 20)
      contentsView
    }
  }
}

struct BrandOfMonthView_Previews: PreviewProvider {
  static var previews: some View {
    BrandOfMonthView(
      topTitle: "이달의 브랜드",
      bottomTitle: "최대 15% 적립",
      rightButtonTitle: "보러가기",
      imageNames: [
        BrandOfMonthItem(imageName: "a.circle.fill"),
        BrandOfMonthItem(imageName: "b.circle.fill"),
        BrandOfMonthItem(imageName: "c.circle.fill"),
        BrandOfMonthItem(imageName: "d.circle.fill"),
        BrandOfMonthItem(imageName: "e.circle.fill"),
        BrandOfMonthItem(imageName: "f.circle.fill"),
        BrandOfMonthItem(imageName: "g.circle.fill"),
        BrandOfMonthItem(imageName: "h.circle.fill"),
        BrandOfMonthItem(imageName: "i.circle.fill"),
        BrandOfMonthItem(imageName: "j.circle.fill"),
        BrandOfMonthItem(imageName: "k.circle.fill"),
        BrandOfMonthItem(imageName: "l.circle.fill"),
        BrandOfMonthItem(imageName: "a.circle.fill"),
        BrandOfMonthItem(imageName: "b.circle.fill"),
        BrandOfMonthItem(imageName: "c.circle.fill"),
        BrandOfMonthItem(imageName: "d.circle.fill"),
        BrandOfMonthItem(imageName: "e.circle.fill"),
        BrandOfMonthItem(imageName: "f.circle.fill"),
        BrandOfMonthItem(imageName: "g.circle.fill"),
        BrandOfMonthItem(imageName: "h.circle.fill"),
        BrandOfMonthItem(imageName: "i.circle.fill"),
        BrandOfMonthItem(imageName: "j.circle.fill"),
        BrandOfMonthItem(imageName: "k.circle.fill"),
        BrandOfMonthItem(imageName: "l.circle.fill")
      ]
    ) {
      print("Action")
    }
    .previewLayout(.sizeThatFits)
  }
}

extension BrandOfMonthView {
  
  var topTitleText: some View {
    Text(topTitle)
      .foregroundColor(.black)
      .font(.title3)
      .fontWeight(.semibold)
  }
  
  var bottomTitleText: some View {
    Text(bottomTitle)
      .foregroundColor(.red)
      .font(.title3)
      .fontWeight(.semibold)
  }
  
  var rightButton: some View {
    Button(rightButtonTitle) {
      action()
    }
    .font(.caption)
    .foregroundColor(.black)
    .padding(10)
    .background(Color("gray_D8D8D8"))
    .cornerRadius(10)
  }
  
  var contentsView: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(alignment: .center, spacing: 10) {
        ForEach(imageNames) { image in
          Image(systemName: image.imageName)
            .resizable()
            .frame(width: 70, height: 70)
            .cornerRadius(35)
            .foregroundColor(.blue)
        }
      }
      .frame(height: 70)
      .offset(x: xOffset, y: 0)
    }
    .onAppear {
      withAnimation(.linear(duration: 15).repeatForever(autoreverses: false)) {
        xOffset = -960
      }
    }
  }
}
