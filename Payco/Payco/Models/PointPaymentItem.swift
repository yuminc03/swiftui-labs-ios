//
//  PointPaymentItem.swift
//  Payco
//
//  Created by Yumin Chu on 2023/08/27.
//

import Foundation

struct PointPaymentItem: Identifiable, Equatable {
  let id = UUID()
  let title: String
  
  static let dummy: [PointPaymentItem] = [
    .init(title: "전체"),
    .init(title: "온라인"),
    .init(title: "오프라인"),
    .init(title: "NEW")
  ]
}
