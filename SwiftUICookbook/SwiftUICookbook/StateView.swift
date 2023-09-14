//
//  StateView.swift
//  SwiftUICookbook
//
//  Created by Yumin Chu on 2023/09/14.
//

import SwiftUI

struct StateView: View {
  @State private var isSwitchedOn = false
  
  var body: some View {
    VStack {
      Toggle(isOn: $isSwitchedOn) {
        Text("Turn me on or off")
      }
      if isSwitchedOn {
        Text("The switch in on!")
      }
    }
    .padding()
  }
}

struct StateView_Previews: PreviewProvider {
  static var previews: some View {
    StateView()
  }
}
