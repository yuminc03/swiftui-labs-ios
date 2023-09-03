//
//  SeeMorePageTabView.swift
//  Payco
//
//  Created by Yumin Chu on 2023/08/28.
//

import SwiftUI

struct SeeMorePageTabView: View {
  
  @State private var selectedIndex = 1
  private let maxCount: Int
  private let data: [SeeMorePageTabItem]
  private let buttonAction: () -> Void
  
  init(
    maxCount: Int,
    data: [SeeMorePageTabItem],
    buttonAction: @escaping () -> Void
  ) {
    self.maxCount = maxCount
    self.data = data
    self.buttonAction = buttonAction
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
        if newValue == 0 {
          selectedIndex = 4
        } else if newValue == 5 {
          selectedIndex = 1
        }
      }
      CustomPageIndicator(selectedIndex: (selectedIndex == 0) ? 3 : (selectedIndex == 5) ? 1 : selectedIndex - 1 , maxCount: maxCount)
    }
    .frame(height: 380)
    .padding(.horizontal, -20)
  }
}

struct SeeMorePageTabView_Previews: PreviewProvider {
  static var previews: some View {
    SeeMorePageTabView(maxCount: 4, data: SeeMorePageTabItem.dummy) {
      print("tapped")
    }
    .previewLayout(.sizeThatFits)
  }
}
