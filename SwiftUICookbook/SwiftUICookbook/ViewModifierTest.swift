//
//  ViewModifierTest.swift
//  SwiftUICookbook
//
//  Created by Yumin Chu on 2023/09/06.
//

import SwiftUI

struct ViewModifierTest: View {
  var body: some View {
    Text("View Modifier Test")
      .modifier(BoldAndIKtalicModifier())
  }
}

struct ViewModifierTest_Previews: PreviewProvider {
  static var previews: some View {
    ViewModifierTest()
  }
}

struct BoldAndIKtalicModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .fontWeight(.bold)
      .italic()
  }
}
