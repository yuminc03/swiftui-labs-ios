//
//  AnimatePosition.swift
//  SwiftUICookbook
//
//  Created by Yumin Chu on 2023/09/01.
//

import SwiftUI

struct AnimatePosition: View {
  @State private var offset = CGSize(width: 0, height: 0)
  
  var body: some View {
    Image(systemName: "arrow.up")
      .font(.largeTitle)
      .offset(offset)
      .animation(.spring(), value: offset)
      .gesture(
        DragGesture()
          .onChanged { value in
            offset = value.translation
          }
          .onEnded { _ in
            withAnimation {
              offset = .zero
            }
          }
      )
  }
}

struct AnimatePosition_Previews: PreviewProvider {
  static var previews: some View {
    AnimatePosition()
  }
}
