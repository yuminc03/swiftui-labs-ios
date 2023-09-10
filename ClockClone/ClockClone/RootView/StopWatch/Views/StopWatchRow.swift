//
//  StopWatchRow.swift
//  ClockClone
//
//  Created by Yumin Chu on 2023/09/04.
//

import SwiftUI

struct StopWatchRow: View {
  enum ColorType {
    case white
    case red
    case green
    
    var textColor: Color {
      switch self {
      case .white:
        return Color.white
        
      case .red:
        return Color.red
        
      case .green:
        return Color.green
      }
    }
  }
  
  private let labTime: LabTimeItem
  private let colorType: ColorType

  init(labTime: LabTimeItem, colorType: ColorType) {
    self.labTime = labTime
    self.colorType = colorType
  }
  
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
    .foregroundColor(colorType.textColor)
    .padding(.top, 10)
    .background(.black)
  }
}

struct StopWatchRow_Previews: PreviewProvider {
  static var previews: some View {
    StopWatchRow(
      labTime: LabTimeItem(id: 0, savedTime: "00:00.96"),
      colorType: .red
    )
      .previewLayout(.sizeThatFits)
  }
}
