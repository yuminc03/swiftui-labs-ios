//
//  CurrentCardView.swift
//  Payco
//
//  Created by Yumin Chu on 2023/08/28.
//

import SwiftUI

/// 현재 카드(화면 상단 setting된 카드)
struct CurrentCardView: View {
  @State private var animationValue: CGFloat = 0
  private let cardItem: CurrentCardItem
  private let buttonAction: () -> Void
  
  init(cardItem: CurrentCardItem, buttonAction: @escaping () -> Void) {
    self.cardItem = cardItem
    self.buttonAction = buttonAction
  }
  
  var body: some View {
    HStack(alignment: .bottom) {
      VStack(alignment: .leading, spacing: 20) {
        paycoPointText
        cardPoint
        Spacer()
        bankInfoText
      }
      Spacer()
      manageCardButton
    }
    .padding(.horizontal, 20)
    .padding(.vertical, 30)
    .frame(maxWidth: .infinity)
    .frame(height: 200)
    .background {
      ZStack(alignment: .trailing) {
        RoundedRectangle(cornerRadius: 20)
          .fill(
            LinearGradient(
              colors: [.orange, .pink],
              startPoint: .leading,
              endPoint: .trailing
            )
          )
          .aspectRatio(2.0, contentMode: .fit)
        cardImage
      }
    }
  }
}

struct CurrentCardView_Previews: PreviewProvider {
  static var previews: some View {
    CurrentCardView(cardItem: CurrentCardItem.dummy) {
      print("action")
    }
    .previewLayout(.sizeThatFits)
  }
}

extension CurrentCardView {
  
  var paycoPointText: some View {
    Text(cardItem.topLeadingTitle)
      .font(.headline)
      .fontWeight(.semibold)
      .foregroundColor(.white)
  }
  
  var cardPoint: some View {
    HStack(spacing: 10) {
      Text("\(cardItem.point) P")
        .font(.title)
      Image(systemName: "chevron.right")
        .font(.title3)
    }
    .fontWeight(.semibold)
    .foregroundColor(.white)
  }
  
  var bankInfoText: some View {
    Text("\(cardItem.bankName) (\(cardItem.accountNumber))")
      .underline(color: .white)
      .foregroundColor(.white)
      .font(.subheadline)
      .fontWeight(.light)
      .offset(y: -10)
  }
  
  var cardImage: some View {
    Image("card")
      .resizable()
      .scaledToFit()
      .frame(height: 150)
      .offset(x: -10, y: -40)
      .rotation3DEffect(
        .degrees(-animationValue),
        axis: (x: -animationValue, y: animationValue, z: animationValue)
      )
      .onAppear {
        withAnimation(.linear(duration: 1).repeatForever(autoreverses: true)) {
          animationValue = 15
        }
      }
  }
  
  var manageCardButton: some View {
    Button(cardItem.buttonTitle) {
      buttonAction()
    }
    .font(.footnote)
    .foregroundColor(.white)
    .padding(.horizontal, 15)
    .padding(.vertical, 10)
    .background(Color.white.opacity(0.2))
    .cornerRadius(10)
  }
}
