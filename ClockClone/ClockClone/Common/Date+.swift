//
//  Date+.swift
//  ClockClone
//
//  Created by Yumin Chu on 2023/09/13.
//

import Foundation

extension Date {
  static func - (lhs: Date, rhs: Date) -> TimeInterval {
    return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
  }
  
  func toString(format: String = "a h:mm", id: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    dateFormatter.locale = Locale(identifier: "ko_KR")
    dateFormatter.timeZone = TimeZone(identifier: id)
    return dateFormatter.string(from: self)
  }
}
