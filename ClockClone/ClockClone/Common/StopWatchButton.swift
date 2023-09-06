//
//  StopWatchButton.swift
//  ClockClone
//
//  Created by LS-NOTE-00106 on 2023/09/06.
//

import SwiftUI

struct StopWatchButton: View {
  private let title: String
  private let type: StopWatchButtonType
  private let action: () -> Void
  
  init(title: String, type: StopWatchButtonType, action: @escaping () -> Void) {
    self.title = title
    self.type = type
    self.action = action
  }
  
  var body: some View {
    Text(title)
      .font(.body)
      .foregroundColor(type.titleColor)
      .frame(width: 90, height: 90)
      .background {
        ZStack(alignment: .center) {
          Circle()
            .fill(type.buttonColor)
            .frame(width: 90, height: 90)
          Circle()
            .fill(.black)
            .frame(height: 85)
          Circle()
            .fill(type.buttonColor)
            .frame(height: 80)
        }
      }
      .onTapGesture {
        action()
      }
  }
}

struct StopWatchButton_Previews: PreviewProvider {
  static var previews: some View {
    StopWatchButton(title: "일시 정지", type: .orange) {
      print("action")
    }
  }
}
