//
//  WorldClockRow.swift
//  ClockClone
//
//  Created by Yumin Chu on 2023/09/03.
//

import SwiftUI

struct WorldClockRow: View {
  private let worldClockItem: WorldClockItem
  private let isFirstRow: Bool
  private let isEditMode: Bool
  
  init(worldClockItem: WorldClockItem, isFirstRow: Bool, isEditMode: Bool) {
    self.worldClockItem = worldClockItem
    self.isFirstRow = isFirstRow
    self.isEditMode = isEditMode
  }
  
  var body: some View {
    VStack(spacing: 20) {
      if isFirstRow {
        Divider()
          .background(Color.gray)
          .padding(.trailing, -20)
      } else {
        Rectangle()
          .fill(.clear)
          .frame(height: 1)
      }
      HStack(alignment: .center) {
        VStack(alignment: .leading, spacing: 5) {
          parallaxText
          cityName
        }
        Spacer()
        if isEditMode == false {
          HStack(alignment: .lastTextBaseline, spacing: 2) {
            ampmText
            timeText
          }
        }
      }
    }
    .padding(.horizontal, 20)
    .padding(.bottom, 20)
    .background(Color.black)
  }
}

struct WorldClockRow_Previews: PreviewProvider {
  static var previews: some View {
    WorldClockRow(
      worldClockItem: WorldClockItem(
        parallax: "오늘, +0시간",
        cityName: "서울",
        time: "오후 7:00"
      ),
      isFirstRow: true,
      isEditMode: false
    )
    .previewLayout(.sizeThatFits)
  }
}

extension WorldClockRow {
  
  var parallaxText: some View {
    Text(worldClockItem.parallax)
      .foregroundColor(.gray)
      .font(.body)
  }
  
  var cityName: some View {
    Text(worldClockItem.cityName.components(separatedBy: " ").first ?? "")
      .font(.title)
  }
  
  var ampmText: some View {
    Text(worldClockItem.time.components(separatedBy: " ").first ?? "")
      .font(.largeTitle)
      .fontWeight(.light)
  }
  
  var timeText: some View {
    Text(worldClockItem.time.components(separatedBy: " ").last ?? "")
      .font(.system(size: 52))
      .fontWeight(.light)
  }
}
