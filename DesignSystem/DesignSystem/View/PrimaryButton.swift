//
//  PrimaryButton.swift
//  DesignSystem
//
//  Created by Yumin Chu on 2023/09/12.
//

import SwiftUI

struct PrimaryButton: View {
  private let title: String
  private let titleColor: Color
  private let titleFont: Font
  private let backgroundColor: Color
  private let disableColor: Color
  private let action: () -> Void
  @Environment(\.isEnabled) var isEnabled
  
  init(
    title: String = "확인",
    titleColor: Color = .white,
    titleFont: Font = .headline,
    backgroundColor: Color = Color("green_07D329"),
    disableColor: Color = Color("green_07D329"),
    action: @escaping () -> Void
  ) {
    self.title = title
    self.titleColor = titleColor
    self.titleFont = titleFont
    self.backgroundColor = backgroundColor
    self.disableColor = disableColor
    self.action = action
  }
  
  var body: some View {
    Button {
      action()
    } label: {
      Text(title)
        .customButtonStyle(
          backgroundColor: isEnabled ? backgroundColor : disableColor,
          foregroundColor: titleColor,
          titleFont: titleFont
        )
    }
    .animation(.linear(duration: 0.5), value: isEnabled)
  }
}

struct PrimaryButton_Previews: PreviewProvider {
  static var previews: some View {
    PrimaryButton {
      
    }
    .disabled(false)
    .previewLayout(.sizeThatFits)
  }
}
