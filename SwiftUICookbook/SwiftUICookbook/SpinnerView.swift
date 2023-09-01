//
//  SpinnerView.swift
//  SwiftUICookbook
//
//  Created by Yumin Chu on 2023/08/31.
//

import SwiftUI

struct SpinnerView: View {
  var body: some View {
    ProgressView()
      .progressViewStyle(CircularProgressViewStyle(tint: .blue))
      .scaleEffect(2.0, anchor: .center)
      .onAppear {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
          // Sijmulates a delay in content loading
          // Perform transition to the next view here
        }
      }
  }
}

struct SpinnerView_Previews: PreviewProvider {
  static var previews: some View {
    SpinnerView()
  }
}
