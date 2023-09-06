//
//  TimerSoundRow.swift
//  ClockClone
//
//  Created by Yumin Chu on 2023/09/06.
//

import SwiftUI

struct TimerSoundRow: View {
  private let title: String
  private let selectedName: String
  
  init(title: String, selectedName: String) {
    self.title = title
    self.selectedName = selectedName
  }
  
  var body: some View {
    HStack(alignment: .center, spacing: 20) {
      Text(title)
        .font(.headline)
        .foregroundColor(.white)
      Spacer()
      HStack(spacing: 10) {
        Text(selectedName)
          .font(.headline)
        Image(systemName: "chevron.right")
          .font(.subheadline)
      }
      .foregroundColor(.gray)
    }
    .padding(20)
    .background(Color("gray_272727"))
    .cornerRadius(10)
  }
}

struct TimerSoundRow_Previews: PreviewProvider {
  static var previews: some View {
    TimerSoundRow(title: "타이머 종료 시", selectedName: "프레스토")
      .previewLayout(.sizeThatFits)
  }
}
