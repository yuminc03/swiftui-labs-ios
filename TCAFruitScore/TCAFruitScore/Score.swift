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
  
  
}
