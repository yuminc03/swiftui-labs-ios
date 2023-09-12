//
//  CustomAlertView.swift
//  DesignSystem
//
//  Created by Yumin Chu on 2023/09/10.
//

import SwiftUI

struct CustomAlertView: View {
  @Binding private var isPresented: Bool
  private let title: String
  private let contents: String
  private let description: String
  private let primaryButtonTitle: String
  private let secondaryButtonTitle: String
  private let primaryButtonAction: (() -> Void)?
  private let secondaryButtonAction: (() -> Void)?
  @State private var popupBackgroundOpacity = 0.0
  @State private var popupYOffset: CGFloat = UIScreen.main.bounds.height
  
  init(
    isPresented: Binding<Bool>,
    title: String = "안내",
    contents: String = "내용",
    description: String = "",
    primaryButtonTitle: String = "확인",
    secondaryButtonTitle: String = "취소",
    primaryButtonAction: (() -> Void)? = nil,
    secondaryButtonAction: (() -> Void)? = nil
  ) {
    self._isPresented = isPresented
    self.title = title
    self.contents = contents
    self.description = description
    self.primaryButtonTitle = primaryButtonTitle
    self.secondaryButtonTitle = secondaryButtonTitle
    self.primaryButtonAction = primaryButtonAction
    self.secondaryButtonAction = secondaryButtonAction
  }
  
  var body: some View {
    ZStack {
      Color.gray.opacity(popupBackgroundOpacity)
        .animation(.linear(duration: 0.2), value: popupBackgroundOpacity)
        .ignoresSafeArea()
      if isPresented {
        VStack(spacing: 40) {
          titleText
          VStack(spacing: 20) {
            contentsText
            if description.isEmpty == false {
              descriptionText
            }
          }
          HStack(spacing: 10) {
            secondaryButton
            primaryButton
          }
          .foregroundColor(.white)
        }
        .popupContainer()
        .offset(y: popupYOffset)
        .onAppear {
          popupBackgroundOpacity = 0.6
          popupYOffset = 0
        }
      }
    }
    .background(.clear)
    .animation(.spring(), value: popupYOffset)
  }
}

struct CustomAlertView_Previews: PreviewProvider {
  static var previews: some View {
    CustomAlertView(isPresented: .constant(true))
      .previewLayout(.sizeThatFits)
  }
}

extension CustomAlertView {
  private var titleText: some View {
    Text(title)
      .foregroundColor(Color("gray_C7C7C7"))
  }
  
  private var contentsText: some View {
    Text(contents)
      .frame(minHeight: description.isEmpty ? 84 : .leastNormalMagnitude)
      .foregroundColor(Color("black_2F2F2F"))
  }
  
  private var descriptionText: some View {
    Text(description)
      .foregroundColor(Color("gray_909090"))
  }
  
  private var secondaryButton: some View {
    Button(secondaryButtonTitle) {
      isPresented = false
      popupBackgroundOpacity = 0.0
      popupYOffset = UIScreen.main.bounds.height
      secondaryButtonAction?()
    }
    .customButtonStyle(backgroundColor: Color("gray_B0B0B0"))
  }
  
  private var primaryButton: some View {
    Button(primaryButtonTitle) {
      isPresented = false
      popupBackgroundOpacity = 0.0
      popupYOffset = UIScreen.main.bounds.height
      primaryButtonAction?()
    }
    .customButtonStyle(backgroundColor: Color("green_07D329"))
  }
}
