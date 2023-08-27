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
    .padding(10)
    .foregroundColor(isSelected ? .white : .black)
    .fontWeight(isSelected ? .semibold : .regular)
    .font(.body)
    .background {
      isSelected ? Color.black : Color("gray_D8D8D8")
    }
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
          isSelected: .constant(index == 0 ? true : false)
        )
      }
    }
    .scaledToFit()
    .previewLayout(.sizeThatFits)
  }
}
