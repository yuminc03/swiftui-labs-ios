//
//  StateObjectView.swift
//  SwiftUICookbook
//
//  Created by Yumin Chu on 2023/09/15.
//

import SwiftUI

class TimerManager: ObservableObject {
  @Published var timerCount = 0
  private var timer = Timer()
  
  func start() {
    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
      self.timerCount += 1
    })
  }
  
  func stop() {
    timer.invalidate()
  }
}

struct StateObjectView: View {
  @StateObject private var timerManager = TimerManager()
  
  var body: some View {
    VStack {
      Text("Timer count: \(timerManager.timerCount)")
      Button {
        timerManager.start()
      } label: {
        Text("Start Timer")
      }
      Button {
        timerManager.stop()
      } label: {
        Text("Stop Timer")
      }
    }
  }
}

struct StateObjectView_Previews: PreviewProvider {
  static var previews: some View {
    StateObjectView()
  }
}
