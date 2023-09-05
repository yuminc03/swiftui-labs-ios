//
//  RoundedRectangleImage.swift
//  Payco
//
//  Created by Yumin Chu on 2023/09/05.
//

import SwiftUI

struct RoundedRectangleImage: ViewModifier {
  
  func body(content: Content) -> some View {
    content
      .scaledToFill()
      .frame(width: 120, height: 120)
      .cornerRadius(20)
  }
}

extension View {
  
  func roundedRectangleImage() -> some View {
    modifier(RoundedRectangleImage())
  }
}
