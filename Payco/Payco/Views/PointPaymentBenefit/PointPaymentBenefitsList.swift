//
//  PointPaymentBenefitsList.swift
//  Payco
//
//  Created by Yumin Chu on 2023/08/30.
//

import SwiftUI

/// 8월 포인트 결제 혜택 view
struct PointPaymentBenefitsList: View {
  
  private let currentPointPaymentPage: Int
  private let pageCount: Int
  private let menuTitles: [PointPaymentItem]
  private let menuStatus: [Bool]
  private let menuItemAction: (Int) -> Void
  private let buttonAction: () -> Void
  
  init(
    currentPointPaymentPage: Int,
    pageCount: Int,
    menuTitles: [PointPaymentItem],
    menuStatus: [Bool],
    menuItemAction: @escaping (Int) -> Void,
    buttonAction: @escaping () -> Void
  ) {
    self.currentPointPaymentPage = currentPointPaymentPage
    self.pageCount = pageCount
    self.menuTitles = menuTitles
    self.menuStatus = menuStatus
    self.menuItemAction = menuItemAction
    self.buttonAction = buttonAction
  }
  
  var body: some View {
    VStack(spacing: 30) {
      title
      menu
      list
      PointPaymentMoreLoadButton(
        title: "더보기",
        currentPage: currentPointPaymentPage,
        pageCount: pageCount
      ) {
        buttonAction()
      }
    }
    .padding(20)
    .background {
      RoundedRectangle(cornerRadius: 20)
        .foregroundColor(Color("gray_EAEAEA"))
    }
    .padding(.horizontal, 20)
  }
}

struct PointPaymentBenefitsList_Previews: PreviewProvider {
  static var previews: some View {
    PointPaymentBenefitsList(
      currentPointPaymentPage: 4,
      pageCount: 8,
      menuTitles: PointPaymentItem.dummy,
      menuStatus: [true] + Array(repeating: false, count: PointPaymentItem.dummy.count - 1)
    ) { _ in
      print("menu action")
    } buttonAction: {
      print("button action")
    }
    .previewLayout(.sizeThatFits)
  }
}

extension PointPaymentBenefitsList {
  
  var title: some View {
    // text leading, frame infinity
    HStack {
      Text("8월 포인트 결제 혜택")
        .font(.title2)
        .bold()
      Spacer()
    }
  }
  
  var menu: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      LazyHGrid( // stack
        rows: [GridItem(.flexible(), spacing: 10, alignment: .center)],
        spacing: 15
      ) {
        ForEach(0 ..< 4) { index in
          PointPaymentItemButton(
            title: menuTitles[index].title,
            isSelected: menuStatus[index],
            tag: index
          ) {
            menuItemAction(index)
          } // tapGesture
        }
      }
    }
    .frame(height: 50)
  }
  
  var list: some View {
    VStack(spacing: 20) {
      if let index = menuStatus.firstIndex(of: true) {
        if index == 0 {
          pointPaymentAllItem
        } else if index == 1 {
          pointPaymentOnlineItem
        } else if index == 2 {
          pointPaymentOfflineItem
        } else if index == 3 {
          pointPaymentNewItem
        }
      }
    }
  }
  
  var pointPaymentAllItem: some View {
    ForEach(0 ..< 4) { index in
      PointPaymentListItem(
        topTitle: PointPaymentRow.dummy1[index].toptitle,
        bottomTitle: PointPaymentRow.dummy1[index].bottomTitle,
        imageName: PointPaymentRow.dummy1[index].imageName
      )
    }
  }
  
  var pointPaymentOnlineItem: some View {
    ForEach(0 ..< 4) { index in
      PointPaymentListItem(
        topTitle: PointPaymentRow.dummy2[index].toptitle,
        bottomTitle: PointPaymentRow.dummy2[index].bottomTitle,
        imageName: PointPaymentRow.dummy2[index].imageName
      )
    }
  }
  
  var pointPaymentOfflineItem: some View {
    ForEach(0 ..< 4) { index in
      PointPaymentListItem(
        topTitle: PointPaymentRow.dummy3[index].toptitle,
        bottomTitle: PointPaymentRow.dummy3[index].bottomTitle,
        imageName: PointPaymentRow.dummy3[index].imageName
      )
    }
  }
  
  var pointPaymentNewItem: some View {
    ForEach(0 ..< 4) { index in
      PointPaymentListItem(
        topTitle: PointPaymentRow.dummy4[index].toptitle,
        bottomTitle: PointPaymentRow.dummy4[index].bottomTitle,
        imageName: PointPaymentRow.dummy4[index].imageName
      )
    }
  }
}
