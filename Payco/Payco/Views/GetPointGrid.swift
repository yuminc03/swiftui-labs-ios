//
//  GetPointGrid.swift
//  Payco
//
//  Created by Yumin Chu on 2023/08/28.
//

import SwiftUI

struct GetPointGrid: View {
  
  @State private var selectedIndex = GetPoint.dummy.count
  private let maxCount: Int
  private let data: [GetPoint]
  private let buttonAction: () -> Void
  private let indexChange: (Int) -> Void
  
  init(
    maxCount: Int,
    data: [GetPoint],
    buttonAction: @escaping () -> Void,
    indexChange: @escaping (Int) -> Void
  ) {
    self.maxCount = maxCount
    self.data = data
    self.buttonAction = buttonAction
    self.indexChange = indexChange
  }
  
  var body: some View {
    VStack(spacing: 10) {
      TabView(selection: $selectedIndex) {
        ForEach(0 ..< data.count) { index in
          GetPointItem(data: data[index], index: index) {
            buttonAction()
          }
        }
      }
      .tabViewStyle(.page(indexDisplayMode: .never))
      .onChange(of: selectedIndex) { newValue in
        if newValue == 0 {
          selectedIndex = GetPoint.dummy.count
        } else if newValue == data.count - 1 {
          selectedIndex = GetPoint.dummy.count + GetPoint.dummy.count - 1
        }
        indexChange(newValue)
      }
      CustomPageTabView(selectedIndex: selectedIndex % 4, maxCount: maxCount)
    }
  }
}

struct GetPointGrid_Previews: PreviewProvider {
  static var previews: some View {
    GetPointGrid(maxCount: 4, data: GetPoint.dummy) {
      print("tapped")
    } indexChange: { index in
      print("\(index) changed")
    }
    .previewLayout(.sizeThatFits)
  }
}
