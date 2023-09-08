//
//  TimerProgressBarView.swift
//  ClockClone
//
//  Created by Yumin Chu on 2023/09/06.
//

import SwiftUI

struct TimerProgressBarView: View {
  
  private let percent: CGFloat
  private let hour: String
  private let minute: String
  private let second: String
  private let alarmTime: String
  
  init(percent: CGFloat, hour: String, minute: String, second: String, alarmTime: String) {
    self.percent = percent
    self.hour = hour
    self.minute = minute
    self.second = second
    self.alarmTime = alarmTime
  }
  
  var body: some View {
    ZStack {
      progressBarBackground
      progressBar
      alarmTimes
    }
    .aspectRatio(1.0, contentMode: .fit)
    .frame(maxWidth: UIScreen.main.bounds.width - 40)
  }
}

struct TimerProgressBarView_Previews: PreviewProvider {
  static var previews: some View {
    TimerProgressBarView(percent: 90, hour: "10", minute: "00", second: "10", alarmTime: "오후 4:24")
      .previewLayout(.sizeThatFits)
  }
}

extension TimerProgressBarView {
  
  var progressBarBackground: some View {
    GeometryReader { proxy in
      Circle()
        .stroke(
          Color("gray_424242"),
          style: StrokeStyle(lineWidth: 10, lineCap: .round)
        )
        .frame(width: proxy.size.width, height: proxy.size.height)
    }
  }
  
  var progressBar: some View {
    GeometryReader { proxy in
      Circle()
        .trim(from: 1 - (percent / 100), to: 1)
        .stroke(.orange, style: StrokeStyle(lineWidth: 10, lineCap: .round))
        .frame(width: proxy.size.width, height: proxy.size.height)
        .rotationEffect(.degrees(90))
        .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
        .animation(.linear(duration: 1.0), value: percent)
    }
  }
  
  var alarmTimes: some View {
    GeometryReader { proxy in
      VStack(spacing: 20) {
        HStack(spacing: 2) {
          if hour != "00" {
            Text(hour)
              .frame(width: 95, alignment: .trailing)
            Text(":")
              .frame(width: 15)
          }
          Text(minute)
            .frame(width: 95)
          Text(":")
            .frame(width: 15)
          Text(second)
            .frame(width: 95, alignment: .leading)
        }
        .font(.system(size: 60, weight: .thin))
        Label(alarmTime, systemImage: "bell.fill")
          .foregroundColor(.gray)
          .font(.title3)
      }
      .frame(width: proxy.size.width, height: proxy.size.height)
    }
  }
}
