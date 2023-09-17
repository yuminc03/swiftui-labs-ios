//
//  CustomPopupView.swift
//  DesignSystem
//
//  Created by Yumin Chu on 2023/09/10.
//

import SwiftUI

struct CustomPopupView: View {
  @Binding private var item: PopupItem?
  private let primaryButtonAction: (() -> Void)?
  private let secondaryButtonAction: (() -> Void)?
  @State private var popupBackgroundOpacity = 0.0
  @State private var popupYOffset: CGFloat = UIScreen.main.bounds.height
  
  init(
    item: Binding<PopupItem?>,
    primaryButtonAction: (() -> Void)?,
    secondaryButtonAction: (() -> Void)?
  ) {
    self._item = item
    self.primaryButtonAction = primaryButtonAction
    self.secondaryButtonAction = secondaryButtonAction
  }
  
  var body: some View {
    ZStack {
      Color.gray.opacity(popupBackgroundOpacity)
        .animation(.linear(duration: 0.2), value: popupBackgroundOpacity)
        .ignoresSafeArea()
      if let item {
        VStack(spacing: 40) {
          titleText(item)
          contentsView(item)
          buttonsView(item)
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
      item: .constant(PopupItem.treatmentAlert),
      primaryButtonAction: nil,
      secondaryButtonAction: nil
    )
    .previewLayout(.sizeThatFits)
  }
}

extension CustomPopupView {
  
  private func titleText(_ item: PopupItem) -> some View {
    Text(item.title)
      .foregroundColor(Color("gray_C7C7C7"))
  }
  
  private func contentsView(_ item: PopupItem) -> some View {
    VStack(spacing: 20) {
      contentsText(item)
      if item.description.isEmpty == false {
        descriptionText(item)
      }
    }
  }
  
  private func contentsText(_ item: PopupItem) -> some View {
    Text(item.contents)
      .multilineTextAlignment(.center)
      .frame(minHeight: item.description.isEmpty ? 84 : .leastNormalMagnitude, alignment: .center)
      .foregroundColor(Color("black_2F2F2F"))
  }
  
  private func descriptionText(_ item: PopupItem) -> some View {
    Text(item.description)
      .foregroundColor(Color("gray_909090"))
  }
  
  private func buttonsView(_ item: PopupItem) -> some View {
    HStack(spacing: 10) {
      if item.secondaryButtonTitle.isEmpty == false {
        secondaryButton(item)
      }
      primaryButton(item)
    }
    .foregroundColor(.white)
  }
  
  private func primaryButton(_ item: PopupItem) -> some View {
    PrimaryButton(title: "확인") {
      dismissAction()
      primaryButtonAction?()
    }
  }
  
  private func secondaryButton(_ item: PopupItem) -> some View {
    PrimaryButton(title: "취소") {
      dismissAction()
      secondaryButtonAction?()
    }
  }
  
  private func dismissAction() {
    item = nil
    popupBackgroundOpacity = 0.0
    popupYOffset = UIScreen.main.bounds.height
  }
}
