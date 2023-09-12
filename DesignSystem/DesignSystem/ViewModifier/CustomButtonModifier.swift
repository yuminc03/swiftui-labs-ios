//
//  CustomButtonModifier.swift
//  DesignSystem
//
//  Created by Yumin Chu on 2023/09/11.
//

import SwiftUI

struct CustomButtonModifier: ViewModifier {
  let backgroundColor: Color
  
  func body(content: Content) -> some View {
    content
      .padding(.vertical, 20)
      .frame(maxWidth: .infinity)
      .background(backgroundColor)
      .cornerRadius(10)
      .contentShape(RoundedRectangle(cornerRadius: 10))
  }
}

extension View {
  func customButtonStyle(backgroundColor: Color) -> some View {
    modifier(CustomButtonModifier(backgroundColor: backgroundColor))
  }
}
