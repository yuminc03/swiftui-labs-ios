//
//  PointPaymentItemButton.swift
//  Payco
//
//  Created by Yumin Chu on 2023/08/27.
//

import SwiftUI

struct PointPaymentItemButton: View {
  
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
    Button(title) {
      action()
    }
    .padding(10)
    .foregroundColor(isSelected ? .white : .black)
    .fontWeight(isSelected ? .semibold : .regular)
    .font(.body)
    .background {
      isSelected ? Color.black : Color("gray_D8D8D8")
    }
    .tag(tag)
    .cornerRadius(30)
  }
}

struct PointPaymentItemButton_Previews: PreviewProvider {
  static var previews: some View {
    LazyHGrid(
      rows: [GridItem(.flexible(), spacing: 10, alignment: .center)],
      spacing: 15
    ) {
      ForEach(0 ..< 4) { index in
        PointPaymentItemButton(
          title: "전체",
          isSelected: index == 0 ? true : false,
          tag: index
        ) {
          print("\(index) button tapped")
        }
      }
    }
    .previewLayout(.sizeThatFits)
  }
}
