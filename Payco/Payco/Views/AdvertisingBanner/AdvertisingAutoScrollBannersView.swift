//
//  AdvertisingAutoScrollBannersView.swift
//  Payco
//
//  Created by Yumin Chu on 2023/08/29.
//

import SwiftUI

struct AdvertisingAutoScrollBannersView: View {
  @State private var selectedIndex = AdvertisePaycoPoint.dummy.count
  @State private var data: [AdvertisePaycoPoint]
  private let onChange: (Int) -> Void
  private let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
  @State private var isDrag = false 
  
  init(
    data: [AdvertisePaycoPoint],
    onChange: @escaping (Int) -> Void
  ) {
    self.data = data
    self.onChange = onChange
  }
  
  var body: some View {
    ScrollViewReader { proxy in
      horizontalScrollView
      .onAppear {
        proxy.scrollTo(selectedIndex, anchor: .center)
      }
      .onReceive(timer) { _ in
        guard isDrag == false else { return }
        if selectedIndex == data.count - 2 {
          selectedIndex = AdvertisePaycoPoint.dummy.count + AdvertisePaycoPoint.dummy.count - 2
          proxy.scrollTo(selectedIndex, anchor: .center)
        } else {
          selectedIndex += 1
          withAnimation(.linear(duration: 3).repeatForever(autoreverses: false)) {
            proxy.scrollTo(selectedIndex, anchor: .center)
          }
        }
      }
      .gesture(
        DragGesture()
          .onEnded { value in
            isDrag = true
            if value.translation.width > 0 {
              if selectedIndex == 1 {
                selectedIndex = AdvertisePaycoPoint.dummy.count + 1
                proxy.scrollTo(selectedIndex, anchor: .center)
                isDrag = false
              } else {
                selectedIndex -= 1
                withAnimation(.spring()) {
                  proxy.scrollTo(selectedIndex, anchor: .center)
                  isDrag = true
                }
              }
            } else {
              if selectedIndex == data.count - 2 {
                selectedIndex = AdvertisePaycoPoint.dummy.count + AdvertisePaycoPoint.dummy.count - 2
                proxy.scrollTo(selectedIndex, anchor: .center)
                isDrag = true
              } else {
                selectedIndex += 1
                withAnimation(.spring()) {
                  proxy.scrollTo(selectedIndex, anchor: .center)
                  isDrag = true
                }
              }
            }
          }
      )
    }
  }
}

struct AdvertisingAutoScrollBannersView_Previews: PreviewProvider {
  static var previews: some View {
    AdvertisingAutoScrollBannersView(data: AdvertisePaycoPoint.dummy) { index in
      print("\(index): change index")
    }
    .previewLayout(.sizeThatFits)
  }
}

extension AdvertisingAutoScrollBannersView {
  
  var horizontalScrollView: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      LazyHStack(spacing: 10) {
        ForEach(0 ..< data.count) { index in
          AdvertisingAutoScrollBanner(
            advertisePaycoPoint: data[index]
          )
          .padding(.leading, index == 0 ? 20 : 0)
          .padding(.trailing, index == data.count - 1 ? 20 : 0)
          .id(index)
        }
      }
    }
    .scrollDisabled(true)
    .frame(height: 230)
  }
}
