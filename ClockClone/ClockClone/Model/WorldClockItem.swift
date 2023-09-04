//
//  WorldClockItem.swift
//  ClockClone
//
//  Created by Yumin Chu on 2023/09/03.
//

import Foundation

struct WorldClockItem: Equatable, Identifiable {
  let id = UUID()
  let parallax: String
  let cityName: String
  let time: String
  
  static let dummy: [WorldClockItem] = [
    .init(parallax: "오늘, +0시간", cityName: "서울", time: CityTime.randomTime)
  ]
}
