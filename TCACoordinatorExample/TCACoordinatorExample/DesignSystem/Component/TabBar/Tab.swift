//
//  Tab.swift
//  TCACoordinatorExample
//
//  Created by LS-NOTE-00106 on 6/20/24.
//

import Foundation

enum Tab: Hashable, CaseIterable {
  case home
  case clinicList
  case prescription
  
  var title: String {
    switch self {
    case .home: return "홈"
    case .clinicList: return "진료"
    case .prescription: return "조제"
    }
  }
  
  var icon: String {
    switch self {
    case .home: return "house"
    case .clinicList: return "stethoscope.circle"
    case .prescription: return "pill"
    }
  }
  
  var selectedIcon: String {
    switch self {
    case .home: return "house.fill"
    case .clinicList: return "stethoscope.circle.fill"
    case .prescription: return "pill.fill"
    }
  }
}
