//
//  AddImageView.swift
//  SwiftUICookbook
//
//  Created by Yumin Chu on 2023/09/03.
//

import SwiftUI

struct AddImageView: View {
  var body: some View {
    Button {
      print("Tapped")
    } label: {
      Text("Press Me!")
        .font(.largeTitle)
        .foregroundColor(.white)
    }
    .padding()
    .background(
      LinearGradient(gradient: Gradient(colors: [.purple, .pink]), startPoint: .topLeading, endPoint: .bottomTrailing)
    )
    .cornerRadius(10)
  }
}

struct AddImageView_Previews: PreviewProvider {
  static var previews: some View {
    AddImageView()
  }
}
