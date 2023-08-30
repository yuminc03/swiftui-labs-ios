//
//  PaycoRewordRow.swift
//  Payco
//
//  Created by Yumin Chu on 2023/08/27.
//

import SwiftUI

struct PaycoRewordRow: View {
  
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
    .padding(20)
    .background {
      RoundedRectangle(cornerRadius: 20)
        .foregroundColor(Color("gray_EAEAEA"))
    }
    .padding(.horizontal, 20)
    .padding(.vertical, 10)
  }
}

struct PaycoRewordView_Previews: PreviewProvider {
  static var previews: some View {
    PaycoRewordRow(
      imageName: "dollarsign.circle.fill",
      title: "PAYCO 리워드",
      point: 0
    )
    .previewLayout(.sizeThatFits)
  }
}
