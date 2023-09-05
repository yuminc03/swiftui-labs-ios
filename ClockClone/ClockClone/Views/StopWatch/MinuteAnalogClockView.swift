//
//  MinuteAnalogClockView.swift
//  ClockClone
//
//  Created by Yumin Chu on 2023/09/05.
//

import SwiftUI

struct MinuteAnalogClockView: View {
  
  var body: some View {
    ZStack {
      Circle()
        .fill(.black)
      clockScales
      hourHand
    }
    .aspectRatio(1.0, contentMode: .fit)
    .frame(width: 100)
  }
}

struct MinuteAnalogClockView_Previews: PreviewProvider {
  static var previews: some View {
    MinuteAnalogClockView()
      .previewLayout(.sizeThatFits)
  }
}

extension MinuteAnalogClockView {
  
  var clockScales: some View {
    GeometryReader { proxy in
      ForEach(1 ... 60, id: \.self) { second in
        Path { path in
          path.move(to: CGPoint(
            x: proxy.size.width / 2,
            y: 0
          ))
          path.addLine(to: CGPoint(
            x: proxy.size.width / 2,
            y: second % 2 == 0 ? 10 : 5
          ))
          path.closeSubpath()
        }
        .stroke(second % 6 == 0 ? .white : .gray, lineWidth: 1)
        .rotationEffect(.degrees(Double(second) * (360 / 60)))
      }
    }
  }
  
  var hourHand: some View {
    ZStack {
      GeometryReader { proxy in
        Path { path in
          path.move(to: CGPoint(x: proxy.size.width / 2, y: proxy.size.height / 2))
          path.addLine(to: CGPoint(x: proxy.size.width / 2, y: 0))
        }
        .stroke(.orange, lineWidth: 2)
      }
      Circle()
        .fill(.orange)
        .frame(height: 8)
    }
  }
}
