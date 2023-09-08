//
//  RoundedGrayBackground.swift
//  Payco
//
//  Created by Yumin Chu on 2023/09/05.
//

import SwiftUI

struct RoundedGrayBackground: ViewModifier {
  let padding: CGFloat
  
  func body(content: Content) -> some View {
    content
    .padding(padding)
    .background {
      RoundedRectangle(cornerRadius: 20)
        .foregroundColor(Color("gray_EAEAEA"))
    }
  }
}

extension View {
  
  func roundedGrayBackground(padding: CGFloat = 20) -> some View {
    modifier(RoundedGrayBackground(padding: padding))
  }
}
