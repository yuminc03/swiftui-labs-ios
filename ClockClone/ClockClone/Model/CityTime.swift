//
//  CityTime.swift
//  ClockClone
//
//  Created by LS-NOTE-00106 on 2023/09/04.
//

import Foundation

enum CityTime: String, Equatable, CaseIterable {
  case spanish = "es_ES"
  case thai = "th_TH"
  case korean = "ko_KR"
  case italian = "it_IT"
  case portuguese = "pt_MZ"
  case english = "en_US_POSIX"
  case tonga = "to_TO"
  case icelandic = "is_IS"
  case danish = "da_DK"
  case germany = "de_DE"
  
  static var randomTime: String {
    return CityTime.dummy.randomElement() ?? DateFormat.convertTimeToString(id: CityTime.korean.rawValue)
  }
  
  static let dummy = CityTime.allCases.map { DateFormat.convertTimeToString(id: $0.rawValue) }
}

class DateFormat {
  
  static func convertTimeToString(id: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "a h:mm"
    dateFormatter.locale = Locale(identifier: id)
    return dateFormatter.string(from: Date())
  }
}
