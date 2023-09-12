//
//  CustomPopupView.swift
//  DesignSystem
//
//  Created by Yumin Chu on 2023/09/10.
//

import SwiftUI

struct CustomPopupView: View {
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
    title: String,
    contents: String,
    description: String,
    primaryButtonTitle: String,
    secondaryButtonTitle: String,
    primaryButtonAction: (() -> Void)?,
    secondaryButtonAction: (() -> Void)?
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
          contentsView
          buttonsView
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

struct CustomPopupView_Previews: PreviewProvider {
  static var previews: some View {
    CustomPopupView(
      isPresented: .constant(true),
      title: "안내",
      contents: "내용",
      description: "",
      primaryButtonTitle: "확인",
      secondaryButtonTitle: "취소",
      primaryButtonAction: nil,
      secondaryButtonAction: nil
    )
    .previewLayout(.sizeThatFits)
  }
}

extension CustomPopupView {
  private var titleText: some View {
    Text(title)
      .foregroundColor(Color("gray_C7C7C7"))
  }
  
  private var contentsView: some View {
    VStack(spacing: 20) {
      contentsText
      if description.isEmpty == false {
        descriptionText
      }
    }
  }
  
  private var contentsText: some View {
    Text(contents)
      .multilineTextAlignment(.center)
      .frame(minHeight: description.isEmpty ? 84 : .leastNormalMagnitude, alignment: .center)
      .foregroundColor(Color("black_2F2F2F"))
  }
  
  private var descriptionText: some View {
    Text(description)
      .foregroundColor(Color("gray_909090"))
  }
  
  private var buttonsView: some View {
    HStack(spacing: 10) {
      if secondaryButtonTitle.isEmpty == false {
        secondaryButton
      }
      primaryButton
    }
    .foregroundColor(.white)
  }
  
  private var secondaryButton: some View {
    Button {
      dismissAction()
      secondaryButtonAction?()
    } label: {
      Text(secondaryButtonTitle)
        .customButtonStyle(backgroundColor: Color("gray_B0B0B0"))
    }
  }
  
  private var primaryButton: some View {
    Button {
      dismissAction()
      primaryButtonAction?()
    } label: {
      Text(primaryButtonTitle)
        .customButtonStyle(backgroundColor: Color("green_07D329"))
    }
  }
  
  private func dismissAction() {
    isPresented = false
    popupBackgroundOpacity = 0.0
    popupYOffset = UIScreen.main.bounds.height
  }
}
