//
//  StopWatchView.swift
//  ClockClone
//
//  Created by Yumin Chu on 2023/09/03.
//

import SwiftUI

struct StopWatchView: View {
  var body: some View {
    ZStack {
      Color.black
        .ignoresSafeArea()
      VStack(alignment: .center, spacing: 20) {
        tabView
        Divider()
          .background(.gray)
        Spacer()
        stopWatchButton(title: "랩", titleColor: Color("gray_C7C7C7"))
      }
      .padding(.horizontal, 20)
    }
  }
}

struct StopWatchView_Previews: PreviewProvider {
  static var previews: some View {
    StopWatchView()
  }
}

extension StopWatchView {
  
  var tabView: some View {
    TabView {
      Text("00:00:00")
        .fontWeight(.thin)
        .font(.system(size: 80))
        .minimumScaleFactor(0.01)
      Text("Clock")
    }
    .foregroundColor(.white)
    .tabViewStyle(.page)
  }
  
  private func stopWatchButton(title: String, titleColor: Color) -> some View {
    Text(title)
      .font(.body)
      .foregroundColor(titleColor)
      .padding(30)
      .clipShape(Circle())
      .background {
        ZStack(alignment: .center) {
          Circle()
            .fill(.gray)
          Circle()
            .fill(.black)
          Circle()
            .fill(.gray)
        }
      }
  }
}
