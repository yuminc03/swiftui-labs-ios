//
//  AdvertisePaycoPointTabView.swift
//  Payco
//
//  Created by Yumin Chu on 2023/08/29.
//

import SwiftUI

struct AdvertisePaycoPointTabView: View {
  
  @State private var selectedIndex = 0
  private var data: [AdvertisePaycoPoint]
  private let onChange: (Int) -> Void
  
  init(selectedIndex: State<Int>, data: [AdvertisePaycoPoint], onChange: @escaping (Int) -> Void) {
    self._selectedIndex = selectedIndex
    self.data = data
    self.onChange = onChange
  }
  
  var body: some View {
    TabView(selection: $selectedIndex) {
      ForEach(0 ..< data.count) { index in
        AdvertisePaycoPointItem(
          advertisePaycoPoint: data[index]
        )
        .tag(index)
      }
    }
    .onChange(of: selectedIndex) { newValue in
      onChange(newValue)
    }
    .tabViewStyle(.page(indexDisplayMode: .never))
    .frame(height: 220)
  }
}

struct AdvertisePaycoPointTabView_Previews: PreviewProvider {
  static var previews: some View {
    AdvertisePaycoPointTabView(selectedIndex: .init(initialValue: 0), data: AdvertisePaycoPoint.dummy) { index in
      print("\(index): change index")
    }
  }
}
