//
//  WorldClockRow.swift
//  ClockClone
//
//  Created by Yumin Chu on 2023/09/03.
//

import SwiftUI

struct WorldClockRow: View {
  private let worldClockItem: WorldClockItem
  
  init(worldClockItem: WorldClockItem) {
    self.worldClockItem = worldClockItem
  }
  
  var body: some View {
    VStack(spacing: 20) {
      HStack(alignment: .center) {
        VStack(alignment: .leading, spacing: 5) {
          parallaxText
          cityName
        }
        Spacer()
        HStack(alignment: .lastTextBaseline, spacing: 2) {
          ampmText
          timeText
        }
        .foregroundColor(.white)
      }
      Divider()
        .background(Color.gray)
    }
    .padding(.top, 20)
    .padding(.horizontal, 20)
    .background(Color.black)
  }
}

struct WorldClockRow_Previews: PreviewProvider {
  static var previews: some View {
    WorldClockRow(worldClockItem: WorldClockItem(
      id: UUID(),
      parallax: "오늘, +0시간",
      cityName: "서울",
      isAM: false,
      time: "7:22"
    ))
    .previewLayout(.sizeThatFits)
  }
}

extension WorldClockRow {
  
  var parallaxText: some View {
    Text(worldClockItem.parallax)
      .foregroundColor(.gray)
      .font(.caption)
  }
  
  var cityName: some View {
    Text(worldClockItem.cityName)
      .foregroundColor(.white)
      .font(.title3)
  }
  
  var ampmText: some View {
    Text(worldClockItem.isAM ? "오전" : "오후")
      .font(.title2)
  }
  
  var timeText: some View {
    Text(worldClockItem.time)
      .font(.largeTitle)
  }
}
