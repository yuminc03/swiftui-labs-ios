//
//  RoundedGrayBackground.swift
//  Payco
//
//  Created by Yumin Chu on 2023/09/05.
//

import SwiftUI

struct RoundedGrayBackground: ViewModifier {
  
  func body(content: Content) -> some View {
    content
    .padding(20)
    .background {
      RoundedRectangle(cornerRadius: 20)
        .foregroundColor(Color("gray_EAEAEA"))
    }
  }
}

extension View {
  
  func roundedGrayBackground() -> some View {
    modifier(RoundedGrayBackground())
  }
}
