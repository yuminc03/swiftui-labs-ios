//
//  NavigationBar.swift
//  Payco
//
//  Created by Yumin Chu on 2023/08/30.
//

import SwiftUI

struct NavigationBar: View {
  var body: some View {
    HStack(spacing: 10) {
      Text("포인트")
        .font(.title)
        .bold()
      Spacer()
      NavigationBarButton(type: .ticket(24)) // badge
      NavigationBarButton(type: .notification(3))
      NavigationBarButton(type: .profile)
    }
    .padding(.horizontal, 20)
    .padding(.vertical, 10)
  }
}

struct NavigationBar_Previews: PreviewProvider {
  static var previews: some View {
    NavigationBar()
      .previewLayout(.sizeThatFits)
  }
}
