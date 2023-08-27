//
//  PaycoRewordView.swift
//  Payco
//
//  Created by Yumin Chu on 2023/08/27.
//

import SwiftUI

struct PaycoRewordView: View {
  
  let imageName: String
  let title: String
  let point: Int
  
  var body: some View {
    HStack(spacing: 5) {
      Image(systemName: imageName)
        .font(.title2)
        .foregroundColor(.yellow)
      Text(title)
        .font(.headline)
        .bold()
      Spacer()
      Text("\(point) P")
        .font(.headline)
        .bold()
      Image(systemName: "chevron.right")
        .font(.headline)
        .foregroundColor(.gray)
    }
  }
}

struct PaycoRewordView_Previews: PreviewProvider {
  static var previews: some View {
    PaycoRewordView(
      imageName: "dollarsign.circle.fill",
      title: "PAYCO 리워드",
      point: 0
    )
    .previewLayout(.sizeThatFits)
  }
}
