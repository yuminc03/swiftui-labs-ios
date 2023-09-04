//
//  StopWatchRow.swift
//  ClockClone
//
//  Created by LS-NOTE-00106 on 2023/09/04.
//

import SwiftUI

struct StopWatchRow: View {
  let labTime: LabTimeItem
  
  var body: some View {
    VStack(spacing: 10) {
      HStack(spacing: 20) {
        Text("랩 \(labTime.id)")
          .font(.body)
        Spacer()
        Text(labTime.savedTime)
          .font(.body)
      }
      Divider()
        .background(.gray)
    }
    .foregroundColor(.white)
    .padding(.top, 10)
    .background(.black)
  }
}

struct StopWatchRow_Previews: PreviewProvider {
  static var previews: some View {
    StopWatchRow(labTime: LabTimeItem(id: 0, savedTime: "00:00.96"))
      .previewLayout(.sizeThatFits)
  }
}

extension StopWatchRow {
  
}
