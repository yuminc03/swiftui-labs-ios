//
//  TabItem.swift
//  ClockClone
//
//  Created by Yumin Chu on 2023/09/03.
//

import Foundation

enum TabItem: Equatable, CaseIterable {
  case worldClock
  case alarm
  case stopWatch
  case timer
  
  var imageName: String {
    switch self {
    case .worldClock:
      return "globe"
      
    case .alarm:
      return "alarm.fill"
      
    case .stopWatch:
      return "stopwatch.fill"
      
    case .timer:
      return "timer"
    }
  }
  
  var label: String {
    switch self {
    case .worldClock:
      return "세계 시계"
      
    case .alarm:
      return "알람"
      
    case .stopWatch:
      return "스톱워치"
      
    case .timer:
      return "타이머"
    }
  }
}
