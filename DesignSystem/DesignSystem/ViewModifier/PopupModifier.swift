//
//  PopupModifier.swift
//  DesignSystem
//
//  Created by Yumin Chu on 2023/09/12.
//

import SwiftUI

struct PopupModifier: ViewModifier {
  @Binding var item: Bool
  let title: String
  let contents: String
  let description: String
  let primaryButtonTitle: String
  let secondaryButtonTitle: String
  let primaryButtonAction: (() -> Void)?
  let secondaryButtonAction: (() -> Void)?
  
  func body(content: Content) -> some View {
    /// zStack을 여기에 넣기
    ZStack {
      content
      CustomPopupView(
        isPresented: $isPresented,
        title: title,
        contents: contents,
        description: description,
        primaryButtonTitle: primaryButtonTitle,
        secondaryButtonTitle: secondaryButtonTitle,
        primaryButtonAction: primaryButtonAction,
        secondaryButtonAction: secondaryButtonAction
      )
      .animation(.spring(), value: isPresented)
    }
  }
}

extension View {
  func customAlert(
    item: Binding<AlertItem?>
  ) -> some View {
    modifier(PopupModifier(
      primaryButtonAction: primaryButtonAction,
      secondaryButtonAction: secondaryButtonAction
    ))
  }
  
  func customConfirm(
    isPresented: Binding<Bool>,
    primaryButtonTitle: String = "확인",
    primaryButtonAction: (() -> Void)? = nil
  ) -> some View {
    modifier(PopupModifier(
      primaryButtonAction: primaryButtonAction,
      secondaryButtonAction: nil
    ))
  }
}
