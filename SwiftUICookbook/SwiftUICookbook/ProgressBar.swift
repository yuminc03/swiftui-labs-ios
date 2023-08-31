//
//  ProgressBar.swift
//  SwiftUICookbook
//
//  Created by Yumin Chu on 2023/08/31.
//

import SwiftUI

struct ProgressBar: View {
  @State private var progress: CGFloat = 0
  let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
  
  var body: some View {
    ZStack(alignment: .leading) {
      Rectangle()
        .frame(width: 300, height: 20)
        .opacity(0.3)
        .foregroundColor(.gray)
      
      Rectangle()
        .frame(width: progress * 300, height: 20)
        .foregroundColor(.green)
        .animation(.easeInOut, value: progress)
    }
    .onReceive(timer) { _ in
      if progress < 1.0 {
        progress += 0.01
      }
    }
  }
}

struct ProgressBar_Previews: PreviewProvider {
  static var previews: some View {
    ProgressBar()
  }
}
