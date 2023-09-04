//
//  StopWatchButtonType.swift
//  ClockClone
//
//  Created by LS-NOTE-00106 on 2023/09/04.
//

import SwiftUI

enum StopWatchButtonType {
  case darkGray
  case gray
  case green
  case red
  
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
    }
  }
}
