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
    var isFindFeatureBannerHidden = false
    var selectedIndex = 1
    let cardItem = CardItem.dummy
    var advertisePaycoPoint = AdvertisePaycoPoint.dummy + AdvertisePaycoPoint.dummy + AdvertisePaycoPoint.dummy
    var selectedAdvertiseBannerIndex = 9
    let menu1 = PointMenuItem.dummy
    let pointPaymentItem = PointPaymentItem.dummy
    var pointPaymentStatus = [true] + Array(repeating: false, count: PointPaymentItem.dummy.count - 1)
    var selectedPointPaymentMenuIndex = 0
    var currentPointPaymentPage = 1
    let pointPaymentData1 = PointPaymentRow.dummy1
    let pointPaymentData2 = PointPaymentRow.dummy2
    let pointPaymentData3 = PointPaymentRow.dummy3
    let pointPaymentData4 = PointPaymentRow.dummy4
    let getPointList = GetPoint.dummy + GetPoint.dummy + GetPoint.dummy
    var getPointSelectedIndex = 0
    var brandOfMonthData = BrandOfMonthItem.dummy
    let nowPaycoList = NowPaycoItem.dummy
    var pointPaymentDataCount: Int {
      switch selectedPointPaymentMenuIndex {
      case 0:
        return pointPaymentData1.count
        
      case 1:
        return pointPaymentData2.count
        
      case 2:
        return pointPaymentData3.count
        
      case 3:
        return pointPaymentData4.count
        
      default:
        return pointPaymentData1.count
      }
    }
  }
  
  enum Action {
    case didTapFindFeatureBannerXButton
    case didTapTabItem
    case didChangeAdvertiseBanner(Int)
    case didTapPointPaymentMenu(Int)
    case didTapPointPaymentMoreButton
    case didChangeGetPointSelectedIndex(Int)
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .didTapFindFeatureBannerXButton:
        state.isFindFeatureBannerHidden = true
        return .none
        
      case .didTapTabItem:
        return .none
        
      case let .didChangeAdvertiseBanner(index):
        state.selectedAdvertiseBannerIndex = index
        if index == state.advertisePaycoPoint.count - 1 {
          state.advertisePaycoPoint = state.advertisePaycoPoint + AdvertisePaycoPoint.dummy
        }
        return .none
      
      case let .didTapPointPaymentMenu(index):
        state.pointPaymentStatus = Array(repeating: false, count: PointPaymentItem.dummy.count)
        state.pointPaymentStatus[index] = true
        guard let selectedIndex = state.pointPaymentStatus.firstIndex(of: true) else {
          return .none
        }
        
        state.selectedPointPaymentMenuIndex = selectedIndex
        state.currentPointPaymentPage = 1
        return .none
        
      case .didTapPointPaymentMoreButton:
        if state.currentPointPaymentPage + 1 > state.pointPaymentDataCount / 4 {
          state.currentPointPaymentPage = 1
        } else {
          state.currentPointPaymentPage += 1
        }
        return .none
       
      case let .didChangeGetPointSelectedIndex(index):
        state.getPointSelectedIndex = index
        return .none
      }
    }
  }
}

struct ContentView: View {
  private let store: StoreOf<ContentCore>
  @ObservedObject private var viewStore: ViewStoreOf<ContentCore>
  
  init() {
    self.store = .init(initialState: .init()) {
      ContentCore()
    }
    self.viewStore = ViewStore(store, observe: { $0 })
  }
  
  var body: some View {
    ScrollView(showsIndicators: false) {
      topTitleView
      section1
      section2
      section3
      section4
      section5
      section6
      section7
      section8
    }
    .padding(.init(top: 1, leading: 1, bottom: 1, trailing: 1))
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .previewLayout(.sizeThatFits)
  }
}

extension ContentView {
  
  var topTitleView: some View {
    HStack(spacing: 10) {
      Text("포인트")
        .font(.title)
        .bold()
      Spacer()
      TopRightButton(imageName: "ticket")
      TopRightButton(imageName: "bell")
      TopRightButton(imageName: "person")
    }
    .padding(.horizontal, 20)
  }
  
  var section1: some View {
    CurrentCardItem(cardItem: viewStore.cardItem) {
      print("카드 관리 button action")
    }
    .padding(20)
  }
  
  var section2: some View {
    LazyVGrid(
      columns: [
        GridItem(.flexible(), spacing: 20, alignment: .center),
        GridItem(.flexible(), spacing: 20, alignment: .center),
        GridItem(.flexible(), spacing: 20, alignment: .center),
        GridItem(.flexible(), spacing: 20, alignment: .center)
      ],
      spacing: 20
    ) {
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
    .padding(.horizontal, 20)
    .padding(.vertical, 10)
  }
  
  var section3: some View {
    AdvertisePaycoPointView(
      selectedIndex: .init(initialValue: viewStore.selectedAdvertiseBannerIndex),
      data: viewStore.advertisePaycoPoint
    ) { selectedTabIndex in
      print("\(selectedTabIndex)")
      store.send(.didChangeAdvertiseBanner(selectedTabIndex))
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
        currentPage: viewStore.currentPointPaymentPage,
        pageCount: viewStore.pointPaymentDataCount / 4
      ) {
        store.send(.didTapPointPaymentMoreButton)
      }
    }
    .padding(20)
    .background {
      RoundedRectangle(cornerRadius: 20)
        .foregroundColor(Color("gray_EAEAEA"))
    }
    .padding(.horizontal, 20)
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
    .padding(.horizontal, 20)
    .padding(.vertical, 10)
  }
  
  var section6: some View {
    brandOfMonthView
      .padding(.vertical, 40)
      .background {
        RoundedRectangle(cornerRadius: 20)
          .foregroundColor(Color("gray_EAEAEA"))
      }
      .padding(.horizontal, 20)
  }
  
  var section7: some View {
    getPointView
      .padding(.vertical, 10)
  }
  
  var section8: some View {
    NowPaycoView(
      leftImageName: "camera.viewfinder",
      title: "지금 페이코는",
      images: viewStore.nowPaycoList
    )
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
    LazyHGrid(
      rows: [GridItem(.flexible(), spacing: 10, alignment: .center)],
      spacing: 15
    ) {
      ForEach(0 ..< 4) { index in
        PointPaymentItemButton(
          title: viewStore.pointPaymentItem[index].title,
          isSelected: viewStore.pointPaymentStatus[index],
          tag: index
        ) {
          store.send(.didTapPointPaymentMenu(index))
        }
      }
    }
    .scaledToFit()
  }
  
  var pointPaymnetBenefitContents: some View {
    VStack(spacing: 20) {
      if let index = viewStore.pointPaymentStatus.firstIndex(of: true) {
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
      imageNames: viewStore.brandOfMonthData
    ) {
      print("Action")
    }
  }
  
  var getPointView: some View {
    GetPointGrid(
      maxCount: GetPoint.dummy.count,
      data: viewStore.getPointList
    ) {
      print("PAYCO Red button Action")
    } indexChange: { index in
      store.send(.didChangeGetPointSelectedIndex(index))
    }
    .frame(height: 380)
  }
}
