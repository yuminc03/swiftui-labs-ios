//
//  PrimaryButton.swift
//  DesignSystem
//
//  Created by Yumin Chu on 2023/09/12.
//

import SwiftUI

struct PrimaryButton: View {
  private let title: String
  private var titleColor: Color = .white
  private var titleFont: Font = .headline
  private var backgroundColor: Color = Color("green_07D329")
  private var disableColor: Color = Color("green_07D329")
  private let action: () -> Void
  @Environment(\.isEnabled) var isEnabled
  
  init(title: String = "확인", action: @escaping () -> Void) {
    self.title = title
    self.action = action
  }
  
  var body: some View {
    Button {
      action()
    } label: {
      Text(title)
        .foregroundColor(titleColor)
        .font(titleFont)
        .padding(.vertical, 20)
        .frame(maxWidth: .infinity)
        .background(isEnabled ? backgroundColor : disableColor)
        .cornerRadius(10)
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

extension PrimaryButton {
  
}
