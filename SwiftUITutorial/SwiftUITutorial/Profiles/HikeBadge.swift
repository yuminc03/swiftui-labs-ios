//
//  HikeBadge.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/23.
//

import SwiftUI

struct HikeBadge: View {
  let name: String
  
  var body: some View {
    VStack(alignment: .center) {
      BadgeView()
        .frame(width: 300, height: 300)
        .scaleEffect(1.0 / 3.0)
        .frame(width: 100, height: 100)
      Text(name)
        .font(.caption)
        .accessibilityLabel("Badge for \(name).")
    }
  }
}

struct HikeBadge_Previews: PreviewProvider {
  static var previews: some View {
    HikeBadge(name: "Preview Testing")
  }
}
