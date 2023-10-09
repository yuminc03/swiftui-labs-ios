//
//  ButtonStyle.swift
//  DesignSystem
//
//  Created by Yumin Chu on 2023/10/05.
//

import Foundation
import SwiftUI

struct ButtonTitleColor: ButtonStyle {
  let color: Color
  
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .foregroundColor(color)
  }
}

