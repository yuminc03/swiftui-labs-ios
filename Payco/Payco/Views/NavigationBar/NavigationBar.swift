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
      NavigationBarButton(imageName: "ticket") // badge
      NavigationBarButton(imageName: "bell")
      NavigationBarButton(imageName: "person")
    }
    .padding(.horizontal, 20)
  }
}

struct NavigationBar_Previews: PreviewProvider {
  static var previews: some View {
    NavigationBar()
      .previewLayout(.sizeThatFits)
  }
}
