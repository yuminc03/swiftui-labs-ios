//
//  BlackComment.swift
//  Payco
//
//  Created by Yumin Chu on 2023/09/01.
//

import SwiftUI

struct BlackComment: View {
  
  enum Kind: String {
    case new = "NEW"
    case hot = "NOT"
    case none = " "
    
    var emoticon: String {
      switch self {
      case .new:
        return "✨"
        
      case .hot:
        return "🔥"
        
      case .none:
        return " "
      }
    }
  }
  private let type: Kind
  
  init(type: Kind) {
    self.type = type
  }
  
  var body: some View {
    VStack(spacing: 0) {
      Text("\(type.emoticon)\(type.rawValue)")
        .font(.caption)
        .fontWeight(.bold)
        .foregroundColor(type != .none ? .white : .clear)
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .background(type != .none ? .black : .clear)
        .clipShape(Capsule())
      Triangle()
        .fill(type != .none ? .black : .clear)
        .frame(width: 10, height: 5)
    }
  }
}

struct BlackComment_Previews: PreviewProvider {
  static var previews: some View {
    BlackComment(type: .new)
      .previewLayout(.sizeThatFits)
  }
}

extension BlackComment {
  
  struct Triangle: Shape {

    func path(in rect: CGRect) -> Path {
      var path = Path()
      path.move(to: CGPoint(x: 0, y: 0))
      path.addLine(to: CGPoint(x: rect.midX, y: rect.height))
      path.addLine(to: CGPoint(x: rect.width, y: 0))
      path.addLine(to: CGPoint(x: 0, y: 0))
      path.closeSubpath()
      return path
    }
  }
}
