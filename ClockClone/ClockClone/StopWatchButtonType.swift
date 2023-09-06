//
//  StopWatchButtonType.swift
//  ClockClone
//
//  Created by Yumin Chu on 2023/09/04.
//

import SwiftUI

enum StopWatchButtonType {
  case darkGray
  case gray
  case green
  case red
  case orange
  
  var buttonColor: Color {
    switch self {
    case .darkGray:
      return Color("gray_272727")
      
    case .gray:
      return Color("gray_424242")
      
    case .green:
      return Color("green_005200")
      
    case .red:
      return Color("red_670000")
      
    case .orange:
      return Color("orange_6A441B")
    }
  }
  
  var titleColor: Color {
    switch self {
    case .darkGray:
      return Color("gray_424242")
      
    case .gray:
      return Color("gray_C7C7C7")
      
    case .green:
      return .green
      
    case .red:
      return .red
      
    case .orange:
      return .orange
    }
  }
}
