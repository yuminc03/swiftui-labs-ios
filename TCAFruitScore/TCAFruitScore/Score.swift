//
//  Score.swift
//  TCAFruitScore
//
//  Created by Yumin Chu on 2023/10/06.
//

import Foundation

struct Score: Identifiable, Equatable {
  var id: String {
    return name
  }
  let name: String
  let score: Int
  
  static let dummy: [Score] = [
    .init(name: "사과는 1점", score: 1),
    .init(name: "메론은 10점", score: 10),
    .init(name: "키위는 100점", score: 100)
  ]
}
