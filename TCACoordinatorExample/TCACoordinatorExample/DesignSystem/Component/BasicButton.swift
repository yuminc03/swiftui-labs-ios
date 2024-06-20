//
//  BasicButton.swift
//  TCACoordinatorExample
//
//  Created by LS-NOTE-00106 on 6/20/24.
//

import SwiftUI

struct BasicButton: View {
  let title: String
  let action: () -> Void
  
  var body: some View {
    Button(action: action) {
      Text(title)
        .foregroundColor(.white)
        .padding()
        .background(.blue)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
  }
}

#Preview {
  BasicButton(title: "Push Screen") {
    print("Push")
  }
}
