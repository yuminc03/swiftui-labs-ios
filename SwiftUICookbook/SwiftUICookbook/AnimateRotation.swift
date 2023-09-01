//
//  AnimateRotation.swift
//  SwiftUICookbook
//
//  Created by LS-NOTE-00106 on 2023/09/01.
//

import SwiftUI

struct AnimateRotation: View {
  @State private var rotate = false
  
  var body: some View {
    VStack {
      Button {
        rotate.toggle()
      } label: {
        Text("Rotate")
          .font(.title)
          .fontWeight(.bold)
          .foregroundColor(.white)
          .padding()
          .background(.blue)
          .cornerRadius(10)
      }
      .rotation3DEffect(.degrees(rotate ? 180 : 0), axis: (x: 0, y: 1, z: 0))
      .animation(.easeInOut(duration: 0.5), value: rotate)
    }
  }
}

struct AnimateRotation_Previews: PreviewProvider {
  static var previews: some View {
    AnimateRotation()
  }
}
