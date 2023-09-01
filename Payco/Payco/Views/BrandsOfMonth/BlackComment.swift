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
        .padding(10)
        .background(type != .none ? .black : .clear)
        .cornerRadius(30)
      Rectangle() //삼각형으로 바꿔보기 (path)
        .rotation(Angle(degrees: 45))
        .frame(width: 15, height: 15)
        .foregroundColor(type != .none ? Color.black : Color.clear)
        .offset(y: -10)
    }
  }
}

struct BlackComment_Previews: PreviewProvider {
  static var previews: some View {
    BlackComment(type: .none)
      .previewLayout(.sizeThatFits)
  }
}
