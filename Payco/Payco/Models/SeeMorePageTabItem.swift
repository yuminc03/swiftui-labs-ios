//
//  GetPoint.swift
//  Payco
//
//  Created by Yumin Chu on 2023/08/28.
//

import Foundation

struct SeeMorePageTabItem: Identifiable, Equatable {
  let id = UUID()
  let topCaption: String
  let title: String
  let contents: String
  let imageName: String
  let buttonTitle: String
  
  static let dummy: [SeeMorePageTabItem] = [
    .init(
      topCaption: "",
      title: "결제할 때 사용 가능한\n5천 포인트 바로 받기",
      contents: "신청까지 최대 1분,\n신청완료 즉시 5천P 지급!",
      imageName: "banknote",
      buttonTitle: "카드 신청하기"
    ),
    .init(
      topCaption: "알고 계셨나요?",
      title: "PAYCO 포인트로\n해외결제도 된다는 사실",
      contents: "해외 호텔 & 항공 예약 시\n할인은 기본,\n현지화 출금까지 가능해요",
      imageName: "network",
      buttonTitle: "자세히 보기"
    ),
    .init(
      topCaption: "",
      title: "이달의 브랜드 확인하고\n더 많은 포인트를 적립 받으세요",
      contents: "결제할 때마다\n최대 15%까지 적립!",
      imageName: "laptopcomputer.and.iphone",
      buttonTitle: "이달의 브랜드 보기"
    ),
    .init(
      topCaption: "PAYCO 결제 가능한",
      title: "내 주변 가맹점 확인하고\n주요 브랜드에서 적립 받기",
      contents: "패션, 뷰티 브랜드부터\n집 주변 카페까지!",
      imageName: "creditcard.fill",
      buttonTitle: "주요 브랜드 보기"
    ),
    .init(
      topCaption: "",
      title: "결제할 때 사용 가능한\n5천 포인트 바로 받기",
      contents: "신청까지 최대 1분,\n신청완료 즉시 5천P 지급!",
      imageName: "banknote",
      buttonTitle: "카드 신청하기"
    ),
    .init(
      topCaption: "알고 계셨나요?",
      title: "PAYCO 포인트로\n해외결제도 된다는 사실",
      contents: "해외 호텔 & 항공 예약 시\n할인은 기본,\n현지화 출금까지 가능해요",
      imageName: "network",
      buttonTitle: "자세히 보기"
    )
  ]
}
