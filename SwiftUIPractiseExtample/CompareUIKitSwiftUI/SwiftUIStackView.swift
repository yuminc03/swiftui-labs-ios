//
//  SwiftUIStackView.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 9/21/25.
//

import SwiftUI

struct SwiftUIStackView: View {
  var body: some View {
    VStack(spacing: 20) {
      Image(systemName: "swift")
        .resizable()
        .scaledToFit()
        .frame(height: 100)
        .foregroundStyle(.red)
      
      Text("Answer : Love Myself")
        .font(.system(size: 32, weight: .bold))
      
      Text(
        "시작의 처음부터 끝의 마지막까지 해답은 오직 하나 왜 자꾸만 감추려고만 해 니 가면 속으로\n내 실수로 생긴 흉터까지 다 내 별자린데 You've shown me I have reasons I should love myself 내 숨 내 걸어온 길 전부로 답해"
      )
      .font(.system(size: 20))
    }
    .padding(20)
  }
}

#Preview {
  SwiftUIStackView()
}
