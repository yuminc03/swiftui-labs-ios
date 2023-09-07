//
//  AlarmView.swift
//  ClockClone
//
//  Created by Yumin Chu on 2023/09/03.
//

import SwiftUI

struct AlarmView: View {
  var body: some View {
    VStack(spacing: 20) {
      Image(systemName: "clock.fill")
        .font(.largeTitle)
      Text("알람")
        .font(.largeTitle)
    }
  }
}

struct AlarmView_Previews: PreviewProvider {
  static var previews: some View {
    AlarmView()
  }
}
