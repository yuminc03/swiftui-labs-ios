//
//  DeclareAnimation.swift
//  SwiftUICookbook
//
//  Created by LS-NOTE-00106 on 2023/09/01.
//

import SwiftUI

struct DeclareAnimation: View {
  @State private var isAnimated = false
  
  var body: some View {
    RoundedRectangle(cornerRadius: 20)
      .fill(.blue)
      .frame(width: isAnimated ? 200 : 100, height: 100)
      .animation(.linear(duration: 1), value: isAnimated)
      .onTapGesture {
        isAnimated.toggle()
      }
  }
}

struct DeclareAnimation_Previews: PreviewProvider {
  static var previews: some View {
    DeclareAnimation()
  }
}
