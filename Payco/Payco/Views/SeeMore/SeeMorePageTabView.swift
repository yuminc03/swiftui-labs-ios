//
//  SeeMorePageTabView.swift
//  Payco
//
//  Created by Yumin Chu on 2023/08/28.
//

import SwiftUI

struct SeeMorePageTabView: View {
  
  @State private var selectedIndex = SeeMorePageTabItem.dummy.count
  private let maxCount: Int
  private let data: [SeeMorePageTabItem]
  private let buttonAction: () -> Void
  private let indexChange: (Int) -> Void // 밖에서 selectedIndex를 받거나 없애거나.!
  
  init(
    maxCount: Int,
    data: [SeeMorePageTabItem],
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
          SeeMorePage(data: data[index], index: index) {
            buttonAction()
          }
        }
      }
      .tabViewStyle(.page(indexDisplayMode: .never))
      .onChange(of: selectedIndex) { newValue in
        if newValue == 1 { // 데이터 개수는 6개로!
          selectedIndex = SeeMorePageTabItem.dummy.count + 1
        } else if newValue == data.count - 2 {
          selectedIndex = SeeMorePageTabItem.dummy.count + SeeMorePageTabItem.dummy.count - 2
        }
        indexChange(newValue)
      }
      CustomPageTabView(selectedIndex: selectedIndex % 4, maxCount: maxCount)
    }
    .frame(height: 380)
    .padding(.horizontal, -20)
  }
}

struct SeeMorePageTabView_Previews: PreviewProvider {
  static var previews: some View {
    SeeMorePageTabView(maxCount: 4, data: SeeMorePageTabItem.dummy) {
      print("tapped")
    } indexChange: { index in
      print("\(index) changed")
    }
    .previewLayout(.sizeThatFits)
  }
}
