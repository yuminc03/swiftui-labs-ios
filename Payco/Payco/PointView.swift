//
//  PointView.swift
//  Payco
//
//  Created by Yumin Chu on 2023/08/26.
//

import SwiftUI

import ComposableArchitecture

struct PointCore: Reducer {
  struct State: Equatable {
    var selectedTabIndex = 1
    var isFindFeatureBannerHidden = false
    let cardItem = CurrentCardItem.dummy
    var advertisePaycoPoint = AdvertisePaycoPoint.dummy + AdvertisePaycoPoint.dummy + AdvertisePaycoPoint.dummy
    var selectedAdvertiseBannerIndex = 9
    let menuCollection = MenuCollectionItem.dummy
    let pointPaymentMenuItem = PointPaymentItem.dummy
    var pointPaymentMenuItemStatus = [true] + Array(repeating: false, count: PointPaymentItem.dummy.count - 1)
    var selectedPointPaymentMenuIndex = 0
    var currentPointPaymentPage = 1
    let getPointList = SeeMorePageTabItem.dummy + SeeMorePageTabItem.dummy + SeeMorePageTabItem.dummy
    var getPointSelectedIndex = 0
    let brandOfMonthData = BrandOfMonthItem.dummy + BrandOfMonthItem.dummy + BrandOfMonthItem.dummy
    let nowPaycoList = NowPaycoItem.dummy
    var pointPaymentDataCount: Int {
      switch selectedPointPaymentMenuIndex {
      case 0:
        return PointPaymentRow.dummy1.count
        
      case 1:
        return PointPaymentRow.dummy2.count
        
      case 2:
        return PointPaymentRow.dummy3.count
        
      case 3:
        return PointPaymentRow.dummy4.count
        
      default:
        return PointPaymentRow.dummy1.count
      }
    }
  }
  
  enum Action {
    case didTapDismissButton
    case didTapTabItem
    case didChangeAdvertiseBanner(Int)
    case didTapPointPaymentMenu(Int)
    case didTapPointPaymentMoreButton
    case didChangeGetPointSelectedIndex(Int)
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .didTapDismissButton:
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
        state.pointPaymentMenuItemStatus = Array(repeating: false, count: PointPaymentItem.dummy.count)
        state.pointPaymentMenuItemStatus[index] = true
        guard let selectedIndex = state.pointPaymentMenuItemStatus.firstIndex(of: true) else {
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

struct PointView: View {
  private let store: StoreOf<PointCore>
  @ObservedObject private var viewStore: ViewStoreOf<PointCore>
  
  init() {
    self.store = .init(initialState: .init()) {
      PointCore()
    }
    self.viewStore = ViewStore(store, observe: { $0 })
  }
  
  var body: some View {
    ScrollView(showsIndicators: false) {
      VStack(spacing: 20) {
        NavigationBar()
        CurrentCardView(cardItem: viewStore.cardItem) {
          print("카드 관리 button action")
        }
        MenuCollectionView(data: viewStore.menuCollection)
        AdvertisingAutoScrollBannersView(
          data: viewStore.advertisePaycoPoint
        ) { index in
          store.send(.didChangeAdvertiseBanner(index))
        }
        PointPaymentBenefitsList(
          currentPointPaymentPage: viewStore.currentPointPaymentPage,
          pageCount: viewStore.pointPaymentDataCount / 4,
          menuTitles: viewStore.pointPaymentMenuItem,
          menuStatus: viewStore.pointPaymentMenuItemStatus
        ) { index in
          store.send(.didTapPointPaymentMenu(index))
        } buttonAction: {
          store.send(.didTapPointPaymentMoreButton)
        }
        PaycoRewordRow(
          imageName: "dollarsign.circle.fill",
          title: "PAYCO 리워드",
          point: 0
        )
        BrandsOfMonthAutoScrollView(
          topTitle: "이달의 브랜드",
          bottomTitle: "최대 15% 적립",
          rightButtonTitle: "보러가기",
          imageNames: viewStore.brandOfMonthData
        ) {
          print("BrandsOfMonthAutoScrollView Action")
        }
        SeeMorePageTabView(
          maxCount: SeeMorePageTabItem.dummy.count,
          data: viewStore.getPointList
        ) {
          print("SeeMorePageTabView Red button Action")
        } indexChange: { index in
          store.send(.didChangeGetPointSelectedIndex(index))
        }
        NowPaycoScrollView(
          leftImageName: "camera.viewfinder",
          title: "지금 페이코는",
          images: viewStore.nowPaycoList
        )
        .padding(.bottom, 20)
      }
      .padding(20)
    }
    .padding(.init(top: 1, leading: 0, bottom: 1, trailing: 0))
  }
}

struct PointView_Previews: PreviewProvider {
  static var previews: some View {
    PointView()
      .previewLayout(.sizeThatFits)
  }
}
