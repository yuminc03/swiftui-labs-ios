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
      VStack(spacing: 0) {
        VStack(alignment: .center, spacing: 20) {
          tabView
          HStack(spacing: 0) {
            stopWatchButton(title: "랩", type: .darkGray)
            Spacer()
            stopWatchButton(title: "시작", type: .green)
          }
        }
        .padding(.bottom, 10)
        List {
          Divider()
            .background(.gray)
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .listStyle(.plain)
        .frame(height: UIScreen.main.bounds.height / 3)
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
  
  private func stopWatchButton(title: String, type: StopWatchButtonType) -> some View {
    Text(title)
      .font(.body)
      .foregroundColor(type.titleColor)
      .padding(30)
      .clipShape(Circle())
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
  }
}
