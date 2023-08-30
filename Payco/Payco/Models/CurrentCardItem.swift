//
//  CurrentCardView.swift
//  Payco
//
//  Created by Yumin Chu on 2023/08/28.
//

import Foundation

struct CurrentCardItem: Equatable {
  let topLeadingTitle: String
  let point: Int
  let bankName: String
  let accountNumber: Int
  let buttonTitle: String
  
  static let dummy: CurrentCardItem = .init(
    topLeadingTitle: "PAYCO Point",
    point: 309,
    bankName: "토스뱅크",
    accountNumber: 9920,
    buttonTitle: "카드 관리"
  )
}
