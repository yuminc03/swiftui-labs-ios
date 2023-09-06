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
  case korean = "Asia/Seoul"
  case anguilla = "America/Anguilla"
  case belize = "America/Belize"
  case english = "GMT"
  case casey = "Antarctica/Casey"
  case atyrau = "Asia/Atyrau"
  case gaza = "Asia/Gaza"
  case truk = "Pacific/Truk"
  
  static var randomTime: String {
    return CityTime.dummy.randomElement() ?? DateFormat.convertTimeToString(id: CityTime.korean.rawValue)
  }
  
  static let dummy = CityTime.allCases.map { DateFormat.convertTimeToString(id: $0.rawValue) }
}

class DateFormat {
  
  static func convertTimeToString(id: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "a h:mm"
    dateFormatter.locale = Locale(identifier: Locale.current.identifier)
    dateFormatter.timeZone = TimeZone(identifier: id)
    return dateFormatter.string(from: Date())
  }
}
