//
//  AdvertisePaycoPoint.swift
//  Payco
//
//  Created by Yumin Chu on 2023/08/28.
//

import SwiftUI

struct AdvertisePaycoPoint: Identifiable, Equatable {
  let id = UUID()
  let conditionText: String
  let benefitText: String
  let deadlineText: String
  let imageName: String
  let backgroundColor: Color
  
  static let dummy: [AdvertisePaycoPoint] = [
    .init(
      conditionText: "PAYCO 포인트 결제 시",
      benefitText: "메가MSG커피에서\n15%할인",
      deadlineText: "~ 8.31 까지",
      imageName: "applelogo",
      backgroundColor: .red
    ),
    .init(
      conditionText: "PAYCO 포인트 • 포인트 카드 결제 시",
      benefitText: "GS 더프레시에서\n3,000원 할인",
      deadlineText: "~ 8.31 까지",
      imageName: "creditcard.fill",
      backgroundColor: .green
    ),
    .init(
      conditionText: "PAYCO 포인트 결제 시",
      benefitText: "AK플라자에서\n최대 16% 혜택",
      deadlineText: "~ 8.31 까지",
      imageName: "lanyardcard.fill",
      backgroundColor: .mint
    ),
    .init(
      conditionText: "PAYCO 포인트 • 포인트 카드 결제 시",
      benefitText: "에듀윌에서\n5,000원 할인",
      deadlineText: "~ 9.15 까지",
      imageName: "text.book.closed.fill",
      backgroundColor: .yellow
    ),
    .init(
      conditionText: "PAYCO 포인트 결제 시",
      benefitText: "29CM 쇼핑할 때\n한도 없는 2% 할인!",
      deadlineText: "~ 8.31 까지",
      imageName: "bag.fill",
      backgroundColor: Color("gray_B0B0B0")
    ),
    .init(
      conditionText: "PAYCO 포인트 카드 결제 시",
      benefitText: "G마켓에서 결제하면\n1,000P 페이백!",
      deadlineText: "~ 8.31 까지",
      imageName: "iphone.gen3",
      backgroundColor: .green
    ),
    .init(
      conditionText: "PAYCO 포인트 결제 시",
      benefitText: "무신사에서\n한도없는 2% 할인!",
      deadlineText: "~ 8.31 까지",
      imageName: "cart.fill",
      backgroundColor: .gray
    ),
    .init(
      conditionText: "PAYCO 포인트로 결제 시",
      benefitText: "IBK 계좌 연동하면\n최대 15,000P 혜택!",
      deadlineText: "~ 8.31 까지",
      imageName: "figure.wave",
      backgroundColor: .indigo
    ),
    .init(
      conditionText: "PAYCO 포인트 결제 시",
      benefitText: "GS25 결제 시\n건당 15% 적립",
      deadlineText: "~ 8.31 까지",
      imageName: "giftcard.fill",
      backgroundColor: .blue
    )
  ]
}
