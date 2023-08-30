//
//  NavigationBarButton.swift
//  Payco
//
//  Created by Yumin Chu on 2023/08/26.
//

import SwiftUI

struct NavigationBarButton: View {
  
  let imageName: String
  
  var body: some View {
    Button {
      print(imageName)
    } label: {
      Image(systemName: imageName)
        .font(.title3)
        .fontWeight(.bold)
        .foregroundColor(.black)
    }
  }
}

struct NavigationBarButton_Previews: PreviewProvider {
  static var previews: some View {
    NavigationBarButton(imageName: "ticket")
      .previewLayout(.sizeThatFits)
  }
}
