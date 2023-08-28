//
//  CustomPageTabView.swift
//  Payco
//
//  Created by Yumin Chu on 2023/08/28.
//

import SwiftUI

struct CustomPageTabView: View {
  
  @Binding private var selectedIndex: Int
  private let maxCount: Int
  
  init(selectedIndex: Binding<Int>, maxCount: Int) {
    self._selectedIndex = selectedIndex
    self.maxCount = maxCount
  }
  
  var body: some View {
    HStack(spacing: 5) {
      ForEach(0 ..< maxCount) { index in
        CustomPageTabItem(isSelected: index == selectedIndex)
      }
    }
  }
}

struct CustomPageTabItem: View {
  
  private let isSelected: Bool
  
  init(isSelected: Bool) {
    self.isSelected = isSelected
  }
  
  var body: some View {
    if isSelected {
      RoundedRectangle(cornerRadius: 2.5)
        .fill(.black)
        .frame(width: 25, height: 5)
        .animation(.easeInOut(duration: 0.5), value: isSelected)
    } else {
      RoundedRectangle(cornerRadius: 2.5)
        .fill(Color("gray_EAEAEA"))
        .frame(width: 5, height: 5)
        .animation(.easeInOut(duration: 0.5), value: isSelected)
    }
  }
}

struct CustomPageTabView_Previews: PreviewProvider {
  static var previews: some View {
    CustomPageTabView(selectedIndex: .constant(0), maxCount: 4)
      .previewLayout(.sizeThatFits)
  }
}
