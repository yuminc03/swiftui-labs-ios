//
//  FrameDebugModifier.swift
//  ClockClone
//
//  Created by dudu on 2023/09/06.
//

import SwiftUI

/// 도연 매니저님께서 공유해주신 ViewModifier (디버깅할 때 사용)
struct FrameDebugModifier: ViewModifier {

  let color: Color

  func body(content: Content) -> some View {
    content
    #if DEBUG
      .overlay(GeometryReader(content: overlay(for:)))
    #endif
  }

  private func overlay(for geometry: GeometryProxy) -> some View {
    ZStack(alignment: .topTrailing) {
      Rectangle()
        .strokeBorder(style: .init(lineWidth: 1, dash: [3]))
        .foregroundColor(color)

      Text("(\(Int(geometry.frame(in: .global).origin.x)), \(Int(geometry.frame(in: .global).origin.y))) \(Int(geometry.size.width))x\(Int(geometry.size.height))")
        .font(.caption2)
        .minimumScaleFactor(0.5)
        .foregroundColor(color)
        .padding(3)
        .offset(y: -20)
    }
  }
}

extension View {
  func debug(_ color: Color = .red) -> some View {
    modifier(FrameDebugModifier(color: color))
  }
}
