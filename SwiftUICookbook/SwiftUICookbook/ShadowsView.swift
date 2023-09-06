//
//  ShadowsView.swift
//  SwiftUICookbook
//
//  Created by Yumin Chu on 2023/09/06.
//

import SwiftUI

struct ShadowsView: View {
  var body: some View {
    VStack {
      Text("Shadows!")
        .font(.largeTitle)
        .padding()
        .background(.white)
        .shadow(radius: 10)
      Circle()
        .fill(.blue)
        .shadow(color: .purple, radius: 10, x: 5, y: 5)
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
    }
  }
}

struct ShadowsView_Previews: PreviewProvider {
  static var previews: some View {
    ShadowsView()
  }
}
