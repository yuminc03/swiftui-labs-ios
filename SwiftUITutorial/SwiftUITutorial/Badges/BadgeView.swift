//
//  BadgeView.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/23.
//

import SwiftUI

struct BadgeView: View {
  
    var body: some View {
      ZStack {
        BadgeBackground()
        GeometryReader { geometry in
          badgeSymbols
            .scaleEffect(1.0 / 4.0, anchor: .top)
            .position(x: geometry.size.width / 2.0, y: (3.0 / 4.0) * geometry.size.height)
        }
      }
      .scaledToFit()
    }
}

struct BadgeView_Previews: PreviewProvider {
    static var previews: some View {
        BadgeView()
    }
}

extension BadgeView {
  var badgeSymbols: some View {
    ForEach(0 ..< 8) { index in
      RotatedBadgeSymbol(
        angle: Angle(degrees: Double(index) / Double(8) * 360.0)
      )
    }
    .opacity(0.5)
  }
}
