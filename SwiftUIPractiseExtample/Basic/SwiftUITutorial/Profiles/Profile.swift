//
//  Profile.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/23.
//

import Foundation

struct Profile {
  var username: String
  let prefersNotifications = true
  var seasonalPhoto = Season.winter
  var goalDate = Date()
  
  static let `default` = Profile(username: "lonalia")
  
  enum Season: String, CaseIterable {
    case spring = "🌷"
    case summer = "🌞"
    case autumn = "🍂"
    case winter = "☃️"
    
    var id: String {
      return rawValue
    }
  }
}
