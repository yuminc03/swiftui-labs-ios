//
//  AnimateViewOpacity.swift
//  SwiftUICookbook
//
//  Created by Yumin Chu on 2023/09/01.
//

import SwiftUI

struct AnimateViewOpacity: View {
  @State private var opacity = 0.0
  
  var body: some View {
    VStack {
      Text("Hello SwiftUI!")
        .opacity(opacity)
        .font(.largeTitle)
        .padding()
      
      Button(opacity == 0.0 ?
             "Fade In" : "Fade Out") {
        withAnimation(.easeInOut(duration: 2)) {
          opacity = opacity == 0.0 ? 1.0 : 0.0
        }
      }
    }
  }
}

struct AnimateViewOpacity_Previews: PreviewProvider {
  static var previews: some View {
    AnimateViewOpacity()
  }
}
