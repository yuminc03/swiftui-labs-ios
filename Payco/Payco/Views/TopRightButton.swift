//
//  TopRightButton.swift
//  Payco
//
//  Created by Yumin Chu on 2023/08/26.
//

import SwiftUI

struct TopRightButton: View {
  
  let imageName: String
  
  var body: some View {
    Button {
      print(imageName)
    } label: {
      Image(systemName: imageName)
        .font(.headline)
        .foregroundColor(.black)
    }
  }
}

struct TopRightButton_Previews: PreviewProvider {
  static var previews: some View {
    TopRightButton(imageName: "")
  }
}
