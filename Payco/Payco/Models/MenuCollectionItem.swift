//
//  MenuCollectionItem.swift
//  Payco
//
//  Created by Yumin Chu on 2023/08/26.
//

import SwiftUI

enum MenuCollectionItem: CaseIterable, Identifiable, Equatable {
  case sendMyAccount
  case charge
  case transform
  case usageHistory
  case brand
  case pointGift
  case withDrawalATM
  case incomeDeduction
  
  var id: String {
      return String(describing: self)
  }
  
  var imageName: String {
    switch self {
    case .sendMyAccount:
      return "wonsign.circle.fill"
      
    case .charge:
      return "bolt.circle.fill"
      
    case .transform:
      return "arrow.left.arrow.right.square.fill"
      
    case .usageHistory:
      return "doc.plaintext.fill"
      
    case .brand:
      return "percent"
      
    case .pointGift:
      return "gift.fill"
      
    case .withDrawalATM:
      return "a.square.fill"
      
    case .incomeDeduction:
      return "archivebox.fill"
    }
  }
  
  var title: String {
    switch self {
    case .sendMyAccount:
      return "내계좌로 송금"
      
    case .charge:
      return "충전"
      
    case .transform:
      return "전환"
      
    case .usageHistory:
      return "이용내역"
      
    case .brand:
      return "이달의 브랜드"
      
    case .pointGift:
      return "포인트 선물"
      
    case .withDrawalATM:
      return "ATM 출금"
      
    case .incomeDeduction:
      return "소득공제"
    }
  }
  
  var iconColor: Color {
    switch self {
    case .sendMyAccount:
      return .yellow
      
    case .charge:
      return .indigo
      
    case .transform:
      return .green
      
    case .usageHistory:
      return .secondary
      
    case .brand:
      return .pink
      
    case .pointGift:
      return .purple
      
    case .withDrawalATM:
      return .gray
      
    case .incomeDeduction:
      return .blue
    }
  }
  
  static let dummy = MenuCollectionItem.allCases
}
