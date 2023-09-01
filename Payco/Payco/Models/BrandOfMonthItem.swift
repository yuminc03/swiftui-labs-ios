//
//  BrandOfMonthItem.swift
//  Payco
//
//  Created by Yumin Chu on 2023/08/28.
//

import Foundation
import SwiftUI

struct BrandOfMonthItem: Identifiable, Equatable {
  let id = UUID()
  let imageName: String
  let imageColor: Color
  
  static let dummy: [BrandOfMonthItem] = [
    .init(imageName: "a.circle.fill", imageColor: .red),
    .init(imageName: "b.circle.fill", imageColor: .blue),
    .init(imageName: "c.circle.fill", imageColor: .cyan),
    .init(imageName: "d.circle.fill", imageColor: .yellow),
    .init(imageName: "e.circle.fill", imageColor: .purple),
    .init(imageName: "f.circle.fill", imageColor: .orange),
    .init(imageName: "g.circle.fill", imageColor: .indigo),
    .init(imageName: "h.circle.fill", imageColor: .blue),
    .init(imageName: "i.circle.fill", imageColor: .green),
    .init(imageName: "j.circle.fill", imageColor: .black),
    .init(imageName: "k.circle.fill", imageColor: .gray),
    .init(imageName: "l.circle.fill", imageColor: .black)
  ]
}
