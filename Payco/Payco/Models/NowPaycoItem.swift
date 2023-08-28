//
//  NowPaycoItem.swift
//  Payco
//
//  Created by Yumin Chu on 2023/08/28.
//

import Foundation

struct NowPaycoItem: Identifiable, Equatable {
  let id = UUID()
  let imageName: String
  
  static let dummy: [NowPaycoItem] = [
    .init(imageName: "choco_seolbing"),
    .init(imageName: "choco_drink"),
    .init(imageName: "latte"),
    .init(imageName: "strewberry_cake"),
    .init(imageName: "tomato_pasta")
  ]
}
