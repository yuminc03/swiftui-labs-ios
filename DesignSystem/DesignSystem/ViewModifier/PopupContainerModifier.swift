//
//  PopupContainerModifier.swift
//  DesignSystem
//
//  Created by Yumin Chu on 2023/09/12.
//

import SwiftUI

struct PopupContainerModifier: ViewModifier {
  let minPopupHeight: CGFloat
  
  func body(content: Content) -> some View {
    content
      .font(.headline)
      .padding(20)
      .background {
        RoundedRectangle(cornerRadius: 20)
          .fill(.white)
          .frame(minHeight: minPopupHeight)
      }
      .padding(20)
  }
}

extension View {
  func popupContainer(minPopupHeight: CGFloat = 290) -> some View {
    modifier(PopupContainerModifier(minPopupHeight: minPopupHeight))
  }
}
