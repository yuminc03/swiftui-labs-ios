//
//  AlertModifier.swift
//  DesignSystem
//
//  Created by Yumin Chu on 2023/09/12.
//

import SwiftUI

struct AlertModifier: ViewModifier {
  @Binding var isPresented: Bool
  let title: String
  let contents: String
  let description: String
  let primaryButtonTitle: String
  let secondaryButtonTitle: String
  let primaryButtonAction: (() -> Void)?
  let secondaryButtonAction: (() -> Void)?
  
  func body(content: Content) -> some View {
    content
    CustomAlertView(
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

extension View {
  func customAlert(
    isPresented: Binding<Bool>,
    title: String = "안내",
    contents: String = "내용",
    description: String = "",
    primaryButtonTitle: String = "확인",
    secondaryButtonTitle: String = "취소",
    primaryButtonAction: (() -> Void)? = nil,
    secondaryButtonAction: (() -> Void)? = nil
  ) -> some View {
    modifier(AlertModifier(
      isPresented: isPresented,
      title: title,
      contents: contents,
      description: description,
      primaryButtonTitle: primaryButtonTitle,
      secondaryButtonTitle: secondaryButtonTitle,
      primaryButtonAction: primaryButtonAction,
      secondaryButtonAction: secondaryButtonAction
    ))
  }
  
  func customConfirm(
    isPresented: Binding<Bool>,
    title: String = "안내",
    contents: String = "내용",
    description: String = "",
    primaryButtonTitle: String = "확인",
    primaryButtonAction: (() -> Void)? = nil
  ) -> some View {
    modifier(AlertModifier(
      isPresented: isPresented,
      title: title,
      contents: contents,
      description: description,
      primaryButtonTitle: primaryButtonTitle,
      secondaryButtonTitle: "",
      primaryButtonAction: primaryButtonAction,
      secondaryButtonAction: nil
    ))
  }
}
