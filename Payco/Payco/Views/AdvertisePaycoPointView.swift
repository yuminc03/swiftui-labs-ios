//
//  AdvertisePaycoPointView.swift
//  Payco
//
//  Created by Yumin Chu on 2023/08/29.
//

import SwiftUI

struct AdvertisePaycoPointView: View {
  
  @State private var selectedIndex = 0
  private var data: [AdvertisePaycoPoint]
  private let onChange: (Int) -> Void
  
  init(
    selectedIndex: State<Int>,
    data: [AdvertisePaycoPoint],
    onChange: @escaping (Int) -> Void
  ) {
    self._selectedIndex = selectedIndex
    self.data = data
    self.onChange = onChange
  }
  
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: 10) {
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
  }
}

struct AdvertisePaycoPointView_Previews: PreviewProvider {
  static var previews: some View {
    AdvertisePaycoPointView(selectedIndex: .init(initialValue: 0), data: AdvertisePaycoPoint.dummy) { index in
      print("\(index): change index")
    }
  }
}
