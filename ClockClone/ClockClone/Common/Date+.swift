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
}
