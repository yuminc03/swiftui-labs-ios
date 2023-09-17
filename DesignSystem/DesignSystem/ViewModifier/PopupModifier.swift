//
//  PopupModifier.swift
//  DesignSystem
//
//  Created by Yumin Chu on 2023/09/12.
//

import SwiftUI

struct PopupModifier: ViewModifier {
  @Binding var item: PopupItem?
  let primaryButtonAction: (() -> Void)?
  let secondaryButtonAction: (() -> Void)?
  
  func body(content: Content) -> some View {
    ZStack {
      content
      CustomPopupView(
        item: $item,
        primaryButtonAction: primaryButtonAction,
        secondaryButtonAction: secondaryButtonAction
      )
      .animation(.spring(), value: item)
    }
  }
}

extension View {
  func customAlert(
    item: Binding<PopupItem?>,
    primaryButtonAction: (() -> Void)?,
    secondaryButtonAction: (() -> Void)?
  ) -> some View {
    modifier(PopupModifier(
      item: item,
      primaryButtonAction: primaryButtonAction,
      secondaryButtonAction: secondaryButtonAction
    ))
  }
  
  func customConfirm(
    item: Binding<PopupItem?>,
    primaryButtonAction: (() -> Void)?,
    secondaryButtonAction: (() -> Void)?
  ) -> some View {
    modifier(PopupModifier(
      item: item,
      primaryButtonAction: primaryButtonAction,
      secondaryButtonAction: nil
    ))
  }
}
