//
//  CircleImage.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/23.
//

import SwiftUI

struct CircleImage: View {
  let image: Image
  
  var body: some View {
    image
      .clipShape(Circle())
      .overlay {
        Circle().stroke(.white, lineWidth: 4)
      }
      .shadow(radius: 7)
  }
}

struct CircleImage_Previews: PreviewProvider {
  static var previews: some View {
    CircleImage(image: Image("turtlerock"))
  }
}
