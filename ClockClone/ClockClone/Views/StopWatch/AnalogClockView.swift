//
//  AnalogClockView.swift
//  ClockClone
//
//  Created by Yumin Chu on 2023/09/05.
//

import SwiftUI

struct AnalogClockView: View {
  private let seconds: Int
  private let minute: Int
  
  init(seconds: Int, minute: Int) {
    self.seconds = seconds
    self.minute = minute
  }
  
  var body: some View {
    ZStack {
      Circle()
        .fill(.black)
      MinuteAnalogClockView(minute: minute)
        .offset(y: -UIScreen.main.bounds.width + 330)
      clockShortScales
      clockLongScales
      bigClockHourHand
    }
    .aspectRatio(1.0, contentMode: .fit)
    .frame(maxWidth: UIScreen.main.bounds.width - 40)
    .frame(maxWidth: .infinity)
    .padding(.horizontal, 10)
  }
}

struct AnalogClockView_Previews: PreviewProvider {
  static var previews: some View {
    AnalogClockView(seconds: 10, minute: 1)
      .previewLayout(.sizeThatFits)
  }
}

extension AnalogClockView {
  
  var bigClockHourHand: some View {
    GeometryReader { proxy in
      ZStack {
        Path { path in
          path.move(to: CGPoint(
            x: proxy.size.width / 2,
            y: proxy.size.height / 2 + 40
          ))
          path.addLine(to: CGPoint(
            x: proxy.size.width / 2,
            y: 0
          ))
        }
        .stroke(.orange, lineWidth: 3)
        Circle()
          .fill(.orange)
          .frame(height: 10)
        Circle()
          .fill(.black)
          .frame(height: 5)
      }
      .rotationEffect(.degrees(Double(seconds) * 360 / 60))
      .animation(.linear(duration: 1), value: seconds)
    }
  }
  
  var clockLongScales: some View {
    GeometryReader { proxy in
      ForEach(1 ... 60, id: \.self) { second in
        ZStack {
          Path { path in
            path.move(to: CGPoint(
              x: proxy.size.width / 2,
              y: 0
            ))
            path.addLine(to: CGPoint(
              x: proxy.size.width / 2,
              y: 15
            ))
            path.closeSubpath()
          }
          .stroke(second % 5 == 0 ? .white : .gray, lineWidth: 2)
          .rotationEffect(.degrees(Double(second) * (360 / 60)))
        }
      }
    }
  }
  
  var clockShortScales: some View {
    GeometryReader { proxy in
      ForEach(1 ... 300, id: \.self) { milliSecond in
        Path { path in
          path.move(to: CGPoint(
            x: proxy.size.width / 2,
            y: 0
          ))
          path.addLine(to: CGPoint(
            x: proxy.size.width / 2,
            y: 8
          ))
          path.closeSubpath()
        }
        .stroke(.gray, lineWidth: 2)
        .rotationEffect(.degrees(Double(milliSecond) * (360 / 300)))
      }
    }
  }
  
  var numbers: some View {
    VStack(spacing: 30) {
      HStack(spacing: 0) {
        Text("55")
        Spacer()
        Text("5")
      }
      HStack(spacing: 0) {
        Text("50")
        Spacer()
        Text("10")
      }
      HStack(spacing: 0) {
        Text("45")
        Spacer()
        Text("15")
      }
      HStack(spacing: 0) {
        Text("40")
        Spacer()
        Text("20")
      }
      HStack(spacing: 0) {
        Text("35")
        Spacer()
        Text("25")
      }
    }
    .font(.title)
  }
}
