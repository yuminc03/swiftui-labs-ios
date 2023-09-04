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
  let isAM: Bool
  let time: String
  
  static var koreaTime: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "a HH:mm"
    dateFormatter.locale = Locale(identifier: "ko_KR")
    return dateFormatter.string(from: Date())
  }
  
  static let dummy: [WorldClockItem] = [
    .init(parallax: "오늘, +0시간", cityName: "서울", isAM: false, time: koreaTime)
  ]
}
