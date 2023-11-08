//
//  CircularProgressView.swift
//  TCAExample
//
//  Created by Yumin Chu on 2023/10/27.
//

import SwiftUI

struct CircularProgressView: View {
  private let value: Double
  
  init(value: Double) {
    self.value = value
  }
  
  var body: some View {
    Circle()
      .trim(from: 0, to: CGFloat(value))
      .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round))
      .rotationEffect(.degrees(90))
      .animation(.easeIn, value: value)
  }
}

struct CircularProgressView_Previews: PreviewProvider {
  static var previews: some View {
    CircularProgressView(value: 0.3)
      .frame(width: 44, height: 44)
  }
}
