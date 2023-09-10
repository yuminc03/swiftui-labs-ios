//
//  TimerProgressBarView.swift
//  ClockClone
//
//  Created by Yumin Chu on 2023/09/06.
//

import SwiftUI

struct TimerProgressBarView: View {
  private let percent: CGFloat
  private let currentTime: Int
  private let alarmTime: String
  
  init(percent: CGFloat, currentTime: Int, alarmTime: String) {
    self.percent = percent
    self.currentTime = currentTime
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
    TimerProgressBarView(percent: 50, currentTime: 80, alarmTime: "오후 4:24")
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
        .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0)) // progressBar가 시계 반대 방향으로 회전하도록 x축을 기준으로 180도 뒤집음
        .animation(.linear(duration: 1.0), value: percent)
    }
  }
  
  var alarmTimes: some View {
    GeometryReader { proxy in
      VStack(spacing: 20) {
        Text(convertToText(timerSeconds: currentTime))
        .font(.system(size: 60, weight: .thin))
        .monospacedDigit()
        Label(alarmTime, systemImage: "bell.fill")
          .foregroundColor(.gray)
          .font(.title3)
      }
      .frame(width: proxy.size.width, height: proxy.size.height)
    }
  }
  
  private func convertToText(timerSeconds: Int) -> String {
    if timerSeconds / 3600 == 0 {
      let minute = timerSeconds / 60
      let seconds = timerSeconds % 60
      return String(format: "%02d:%02d", minute, seconds)
    } else {
      let hours = timerSeconds / 3600
      let minute = (timerSeconds - hours * 3600) / 60
      let seconds = timerSeconds % 60
      return String(format: "%02d:%02d:%02d", hours, minute, seconds)
    }
  }
}
