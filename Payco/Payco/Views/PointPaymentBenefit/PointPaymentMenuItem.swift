//
//  PointPaymentItemButton.swift
//  Payco
//
//  Created by Yumin Chu on 2023/08/27.
//

import SwiftUI

struct PointPaymentMenuItem: View {
  
  private let title: String
  private var isSelected: Bool
  private let tag: Int
  private let action: () -> Void
  
  init(
    title: String,
    isSelected: Bool,
    tag: Int,
    action: @escaping () -> Void
  ) {
    self.title = title
    self.isSelected = isSelected
    self.tag = tag
    self.action = action
  }
  
  var body: some View {
    Text(title)
      .onTapGesture {
        action()
      }
      .padding(.horizontal, 15)
      .padding(.vertical, 10)
      .foregroundColor(isSelected ? .white : .black)
      .fontWeight(isSelected ? .semibold : .regular)
      .font(.body)
      .background {
        isSelected ? Color.black : Color("gray_D8D8D8")
      }
      .tag(tag)
      .clipShape(Capsule())
  }
}

struct PointPaymentMenuItem_Previews: PreviewProvider {
  static var previews: some View {
    PointPaymentMenuItem(
      title: "전체",
      isSelected: true,
      tag: 0
    ) {
      print("button tapped")
    }
    .previewLayout(.sizeThatFits)
  }
}
