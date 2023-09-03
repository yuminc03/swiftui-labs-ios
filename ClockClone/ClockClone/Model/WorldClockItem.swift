//
//  WorldClockItem.swift
//  ClockClone
//
//  Created by Yumin Chu on 2023/09/03.
//

import Foundation

struct WorldClockItem: Equatable, Identifiable {
  let id: UUID
  let parallax: String
  let cityName: String
  let isAM: Bool
  let time: String
}
