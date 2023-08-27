//
//  PointPaymentItemButton.swift
//  Payco
//
//  Created by Yumin Chu on 2023/08/27.
//

import SwiftUI

struct PointPaymentItemButton: View {
  
  private let title: String
  @Binding private var isSelected: Bool
  
  init(title: String, isSelected: Binding<Bool>) {
    self.title = title
    self._isSelected = isSelected
  }
  
  var body: some View {
    Button(title) {
      isSelected.toggle()
    }
    .padding(15)
    .foregroundColor(isSelected ? .white : .black)
    .fontWeight(isSelected ? .semibold : .regular)
    .background {
      isSelected ? Color.black : Color("gray_EAEAEA")
    }
    .cornerRadius(30)
  }
}

struct PointPaymentItemButton_Previews: PreviewProvider {
  static var previews: some View {
    PointPaymentItemButton(title: "전체", isSelected: .constant(true))
      .previewLayout(.sizeThatFits)
  }
}
