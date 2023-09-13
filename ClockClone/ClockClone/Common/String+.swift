//
//  String+.swift
//  ClockClone
//
//  Created by Yumin Chu on 2023/09/13.
//

import Foundation

extension String {
  func toDate(format: String = "a h:mm", id: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    dateFormatter.locale = Locale(identifier: "ko_KR")
    dateFormatter.timeZone = TimeZone(identifier: id)
    return dateFormatter.date(from: self)
  }
}
