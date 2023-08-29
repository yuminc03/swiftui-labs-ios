//
//  BrandOfMonthItem.swift
//  Payco
//
//  Created by Yumin Chu on 2023/08/28.
//

import Foundation

struct BrandOfMonthItem: Identifiable, Equatable {
  let id = UUID()
  let imageName: String
  
  static let dummy: [BrandOfMonthItem] = [
    .init(imageName: "a.circle.fill"),
    .init(imageName: "b.circle.fill"),
    .init(imageName: "c.circle.fill"),
    .init(imageName: "d.circle.fill"),
    .init(imageName: "e.circle.fill"),
    .init(imageName: "f.circle.fill"),
    .init(imageName: "g.circle.fill"),
    .init(imageName: "h.circle.fill"),
    .init(imageName: "i.circle.fill"),
    .init(imageName: "j.circle.fill"),
    .init(imageName: "k.circle.fill"),
    .init(imageName: "l.circle.fill"),
    .init(imageName: "a.circle.fill"),
    .init(imageName: "b.circle.fill"),
    .init(imageName: "c.circle.fill"),
    .init(imageName: "d.circle.fill"),
    .init(imageName: "e.circle.fill"),
    .init(imageName: "f.circle.fill"),
    .init(imageName: "g.circle.fill"),
    .init(imageName: "h.circle.fill"),
    .init(imageName: "i.circle.fill"),
    .init(imageName: "j.circle.fill"),
    .init(imageName: "k.circle.fill"),
    .init(imageName: "l.circle.fill")
  ]
}
