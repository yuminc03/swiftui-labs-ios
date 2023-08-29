//
//  AdvertisePaycoPointView.swift
//  Payco
//
//  Created by Yumin Chu on 2023/08/29.
//

import SwiftUI

struct AdvertisePaycoPointView: View {
  @State private var offsetX: CGFloat = 0
  @State private var selectedIndex = AdvertisePaycoPoint.dummy.count
  @State private var data: [AdvertisePaycoPoint]
  private let onChange: (Int) -> Void
  
  private var scrollObservableView: some View {
    GeometryReader { proxy in
      let offsetX = proxy.frame(in: .global).origin.x
      Color.clear
        .preference(key: ScrollOffsetKey.self, value: offsetX)
        .onAppear {
          self.offsetX = offsetX
        }
    }
    .frame(height: 0)
  }

  init(
    data: [AdvertisePaycoPoint],
    onChange: @escaping (Int) -> Void
  ) {
    self.data = data
    self.onChange = onChange
  }
  
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      scrollObservableView
      LazyHStack(spacing: 10) {
        ForEach(0 ..< data.count) { index in
          if index == 0 {
            AdvertisePaycoPointItem(
              advertisePaycoPoint: data[index]
            )
            .padding(.leading, 20)
          } else if index == data.count - 1 {
            AdvertisePaycoPointItem(
              advertisePaycoPoint: data[index]
            )
            .padding(.trailing, 20)
          } else {
            AdvertisePaycoPointItem(
              advertisePaycoPoint: data[index]
            )
          }
        }
      }
    }
    .frame(height: 220)
    .onPreferenceChange(ScrollOffsetKey.self) {
      offsetX = $0
      print("scroll x offset: \($0)")
    }
  }
}

struct AdvertisePaycoPointView_Previews: PreviewProvider {
  static var previews: some View {
    AdvertisePaycoPointView(data: AdvertisePaycoPoint.dummy) { index in
      print("\(index): change index")
    }
  }
}

struct ScrollOffsetKey: PreferenceKey {
  static var defaultValue: CGFloat = 0
  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value += nextValue()
  }
}
