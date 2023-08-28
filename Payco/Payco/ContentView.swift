//
//  ContentView.swift
//  Payco
//
//  Created by Yumin Chu on 2023/08/26.
//

import SwiftUI

import ComposableArchitecture

struct ContentCore: Reducer {
  struct State: Equatable {
    var selectedIndex = 0
    let menu1 = PointMenuItem.dummy
    let menu2 = PointPaymentItem.dummy
    var menu2Status = [true] + Array(repeating: false, count: PointPaymentItem.dummy.count - 1)
    let pointPaymentData1 = PointPaymentRow.dummy1
    let pointPaymentData2 = PointPaymentRow.dummy2
    let pointPaymentData3 = PointPaymentRow.dummy3
    let pointPaymentData4 = PointPaymentRow.dummy4
    var section3MaxGridCount = 6
    var section4CurrentPage = 1
    var getPointList = GetPoint.dummy
    var getPointSelectedIndex = 0
  }
  
  enum Action {
    case didTapTabItem
    case didTapPointPaymentItem
    case increaseSection3MaxCount
    case didTapViewMoreButton
    case didChangeGetPointSelectedIndex
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .didTapTabItem:
        return .none
        
      case .didTapPointPaymentItem:
//        state.menu2Status = Array(repeating: false, count: PointPaymentItem.dummy.count)
//        state.menu2Status[index] = true
        return .none
        
      case .increaseSection3MaxCount:
        state.section3MaxGridCount += 10
        return .none
        
      case .didTapViewMoreButton:
        return .none
        
      case .didChangeGetPointSelectedIndex:
        return .none
      }
    }
  }
}

struct ContentView: View {
  private let columns = [
    GridItem(.flexible(), spacing: 20, alignment: .center),
    GridItem(.flexible(), spacing: 20, alignment: .center),
    GridItem(.flexible(), spacing: 20, alignment: .center),
    GridItem(.flexible(), spacing: 20, alignment: .center)
  ]
  private let pointpaymentBenefitColumns = [
    GridItem(.flexible(), spacing: 10, alignment: .center)
  ]
  private let section3Rows = [
    GridItem(.flexible(), spacing: 10, alignment: .center)
  ]
  private let store: StoreOf<ContentCore>
  @ObservedObject private var viewStore: ViewStoreOf<ContentCore>
  
  init() {
    self.store = .init(initialState: .init()) {
      ContentCore()
    }
    self.viewStore = ViewStore(store, observe: { $0 })
  }
  
  var body: some View {
    NavigationView {
      List {
        Section {
          HStack(spacing: 10) {
            title
            Spacer()
            TopRightButton(imageName: "ticket")
            TopRightButton(imageName: "bell")
            TopRightButton(imageName: "person")
          }
        }
        .listRowSeparator(.hidden)

        Section {
          section1
        }
        .listRowSeparator(.hidden)
        
        Section {
          section2
        }
        .listRowSeparator(.hidden)
        
        Section {
          section3
        }
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets())
        
        Section {
          section4
        }
        .listRowSeparator(.hidden)
        
        Section {
          section5
        }
        .listRowSeparator(.hidden)
        
        Section {
          section6
        }
        .listRowSeparator(.hidden)
        
        Section {
          section7
        }
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets())
        
        Section {
          
        }
        .listRowSeparator(.hidden)
      }
      .listStyle(.plain)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .previewLayout(.sizeThatFits)
  }
}

extension ContentView {
  
  var title: some View {
    Text("포인트")
      .font(.title)
      .bold()
  }
  
  var section1: some View {
    RoundedRectangle(cornerRadius: 20)
      .frame(height: 150)
      .foregroundColor(.gray)
  }
  
  var section2: some View {
    LazyVGrid(columns: columns, spacing: 20) {
      ForEach(viewStore.menu1) { item in
        VStack(spacing: 10) {
          Image(systemName: item.imageName)
            .font(.largeTitle)
            .foregroundColor(item.iconColor)
          Text(item.title)
            .font(.caption)
        }
      }
    }
  }
  
  var section3: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      LazyHGrid(rows: section3Rows) {
        ForEach(0 ... viewStore.section3MaxGridCount, id: \.self) { number in
          if number == 0 {
            section3Item
              .padding(.leading, 20)
              .onAppear {
                if viewStore.section3MaxGridCount % 10 == 6 {
                  store.send(.increaseSection3MaxCount)
                }
              }
          } else {
            section3Item
              .onAppear {
                if viewStore.section3MaxGridCount % 10 == 6 {
                  store.send(.increaseSection3MaxCount)
                }
              }
          }
        }
      }
    }
    .padding(.vertical, 20)
  }
  
  var section4: some View {
    VStack(spacing: 30) {
      pointPaymentBenefitTitle
      pointPaymentBenefitMenu
      pointPaymnetBenefitContents
      PointPaymentMoreLoadButton(
        title: "더보기",
        currentPage: viewStore.binding(
          get: \.section4CurrentPage,
          send: .didTapViewMoreButton
        ),
        pageCount: viewStore.pointPaymentData1.count / 4
      ) {
        print("더보기 tapped")
      }
    }
    .padding(20)
    .background {
      RoundedRectangle(cornerRadius: 20)
        .foregroundColor(Color("gray_EAEAEA"))
    }
  }
  
  var section5: some View {
    PaycoRewordView(
      imageName: "dollarsign.circle.fill",
      title: "PAYCO 리워드",
      point: 0
    )
    .padding(20)
    .background {
      RoundedRectangle(cornerRadius: 20)
        .foregroundColor(Color("gray_EAEAEA"))
    }
  }
  
  var section6: some View {
    brandOfMonthView
      .padding(.vertical, 40)
      .background {
        RoundedRectangle(cornerRadius: 20)
          .foregroundColor(Color("gray_EAEAEA"))
      }
  }
  
  var section7: some View {
    getPointView
      .frame(height: 380)
  }
  
  
  
  var pointPaymentBenefitTitle: some View {
    HStack {
      Text("8월 포인트 결제 혜택")
        .font(.title2)
        .bold()
      Spacer()
    }
  }
  
  var pointPaymentBenefitMenu: some View {
    LazyHGrid(rows: pointpaymentBenefitColumns, spacing: 15) {
      ForEach(0 ..< 4) { index in
        PointPaymentItemButton(
          title: viewStore.menu2[index].title,
          isSelected: viewStore.binding(
            get: \.menu2Status[index],
            send: .didTapPointPaymentItem
          )
        )
      }
    }
    .scaledToFit()
  }
  
  var section3Item: some View {
    RoundedRectangle(cornerRadius: 20)
      .frame(width: UIScreen.main.bounds.width - 40, height: 150)
      .foregroundColor(.gray)
  }
  
  var pointPaymnetBenefitContents: some View {
    VStack(spacing: 20) {
      if let index = viewStore.menu2Status.firstIndex(of: true) {
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
  
  var brandOfMonthView: some View {
    BrandOfMonthView(
      topTitle: "이달의 브랜드",
      bottomTitle: "최대 15% 적립",
      rightButtonTitle: "보러가기",
      imageNames: [
        BrandOfMonthItem(imageName: "a.circle.fill"),
        BrandOfMonthItem(imageName: "b.circle.fill"),
        BrandOfMonthItem(imageName: "c.circle.fill"),
        BrandOfMonthItem(imageName: "d.circle.fill"),
        BrandOfMonthItem(imageName: "e.circle.fill"),
        BrandOfMonthItem(imageName: "f.circle.fill"),
        BrandOfMonthItem(imageName: "g.circle.fill"),
        BrandOfMonthItem(imageName: "h.circle.fill"),
        BrandOfMonthItem(imageName: "i.circle.fill"),
        BrandOfMonthItem(imageName: "j.circle.fill"),
        BrandOfMonthItem(imageName: "k.circle.fill"),
        BrandOfMonthItem(imageName: "l.circle.fill")
      ]
    ) {
      print("Action")
    }
  }
  
  var getPointView: some View {
    GetPointGrid(
      selectedIndex: viewStore.binding(
        get: \.getPointSelectedIndex,
        send: .didChangeGetPointSelectedIndex
      ),
      maxCount: viewStore.getPointList.count,
      data: viewStore.getPointList
    ) {
      print("PAYCO Red button Action")
    }
  }
}
