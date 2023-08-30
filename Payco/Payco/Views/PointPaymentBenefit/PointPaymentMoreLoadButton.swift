//
//  PointPaymentMoreLoadButton.swift
//  Payco
//
//  Created by Yumin Chu on 2023/08/27.
//

import SwiftUI

struct PointPaymentMoreLoadButton: View {
  private let title: String
  private var currentPage: Int
  private let pageCount: Int
  private let action: () -> Void
  
  init(title: String, currentPage: Int, pageCount: Int, action: @escaping () -> Void) {
    self.title = title
    self.currentPage = currentPage
    self.pageCount = pageCount
    self.action = action
  }
  
  var body: some View {
    Button {
      action()
    } label: {
      HStack(spacing: 5) {
        Text(title)
          .font(.body)
          .foregroundColor(.black)
        Text("\(currentPage)")
          .font(.body)
          .foregroundColor(.black)
          .bold()
        Text("/ \(pageCount)")
          .font(.body)
          .foregroundColor(.gray)
      }
      .padding(.horizontal, 20)
      .padding(.vertical, 15)
      .background(Color.white)
      .cornerRadius(30)
      .contentShape(RoundedRectangle(cornerRadius: 30))
    }
  }
}

struct PointPaymentMoreLoadButton_Previews: PreviewProvider {
  static var previews: some View {
    PointPaymentMoreLoadButton(
      title: "더보기",
      currentPage: 8,
      pageCount: 8
    ) {
      print("action")
    }
    .previewLayout(.sizeThatFits)
  }
}
