//
//  AnimateViewSize.swift
//  SwiftUICookbook
//
//  Created by Yumin Chu on 2023/09/01.
//

import SwiftUI

struct AnimateViewSize: View {
  @State private var scale: CGFloat = 1.0
  
  var body: some View {
    Button("Tap Me!") {
      scale += 0.5
    }
    .scaleEffect(scale)
    .animation(.easeInOut(duration: 0.2), value: scale)
  }
}

struct AnimateViewSize_Previews: PreviewProvider {
  static var previews: some View {
    AnimateViewSize()
  }
}
