//
//  CityTime.swift
//  ClockClone
//
//  Created by Yumin Chu on 2023/09/04.
//

import Foundation

enum CityTime: String, Equatable, CaseIterable {
  case abidjan = "Africa/Abidjan"
  case algiers = "Africa/Algiers"
  case anguilla = "America/Anguilla"
  case belize = "America/Belize"
  case english = "GMT"
  case casey = "Antarctica/Casey"
  case atyrau = "Asia/Atyrau"
  case gaza = "Asia/Gaza"
  case truk = "Pacific/Truk"
  
  static var randomID: String {
    return CityTime.allCases.map { $0 }.randomElement()?.rawValue ?? "Asia/Seoul"
  }
}
