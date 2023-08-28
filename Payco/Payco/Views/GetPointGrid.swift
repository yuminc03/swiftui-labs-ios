//
//  GetPointGrid.swift
//  Payco
//
//  Created by Yumin Chu on 2023/08/28.
//

import SwiftUI

struct GetPointGrid: View {
  
  @Binding private var selectedIndex: Int
  private let maxCount: Int
  private let data: [GetPoint]
  private let buttonAction: () -> Void
  
  init(selectedIndex: Binding<Int>, maxCount: Int, data: [GetPoint], buttonAction: @escaping () -> Void) {
    self._selectedIndex = selectedIndex
    self.maxCount = maxCount
    self.data = data
    self.buttonAction = buttonAction
  }
  
  var body: some View {
    VStack(spacing: 20) {
      ScrollView(.horizontal, showsIndicators: false) {
        LazyHGrid(rows: [GridItem(.flexible(), alignment: .center)], spacing: 20) {
          ForEach(0 ..< data.count) { index in
            if index == 0 {
              GetPointItem(data: data[index]) {
                buttonAction()
              }
                .padding(.leading, 20)
            } else {
              GetPointItem(data: data[index]) {
                buttonAction()
              }
            }
          }
        }
      }
      CustomPageTabView(selectedIndex: $selectedIndex, maxCount: maxCount)
    }
  }
}

struct GetPointGrid_Previews: PreviewProvider {
  static var previews: some View {
    GetPointGrid(selectedIndex: .constant(0), maxCount: 4, data: GetPoint.dummy) {
      print("tapped")
    }
      .previewLayout(.sizeThatFits)
  }
}
