//
//  RocketShape.swift
//  SwiftUICookbook
//
//  Created by Yumin Chu on 2023/08/31.
//

import SwiftUI

struct RocketShape: Shape {
  
  func path(in rect: CGRect) -> Path {
    var path = Path()
    
    // body
    path.addRect(
      CGRect(x: rect.midX - 20, y: rect.midY - 60, width: 40, height: 120)
    )
    
    // nose cone
    path.move(to: CGPoint(x: rect.midX , y: rect.midY - 60))
    path.addLine(to: CGPoint(x: rect.midX - 20, y: rect.midY - 40))
    path.addLine(to: CGPoint(x: rect.midX + 20, y: rect.midY - 40))
    path.closeSubpath()
    
    // fines
    path.move(to: CGPoint(x: rect.midX - 20, y: rect.midY + 60))
    path.addLine(to: CGPoint(x: rect.midX - 40, y: rect.midY + 80))
    path.addLine(to: CGPoint(x: rect.midX - 20, y: rect.midY + 60))
    path.closeSubpath()
    
    path.move(to: CGPoint(x: rect.midX + 20, y: rect.midY + 60))
    path.addLine(to: CGPoint(x: rect.midX + 40, y: rect.midY + 80))
    path.addLine(to: CGPoint(x: rect.midX + 20, y: rect.midY + 60))
    path.closeSubpath()
    
    // window
    path.addEllipse(
      in: CGRect(x: rect.midX - 10, y: rect.midY - 50, width: 20, height: 20)
    )
    return path
  }
}

struct RocketShape_Previews: PreviewProvider {
  static var previews: some View {
    RocketShape()
  }
}
