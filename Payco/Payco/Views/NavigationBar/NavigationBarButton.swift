//
//  NavigationBarButton.swift
//  Payco
//
//  Created by Yumin Chu on 2023/08/26.
//

import SwiftUI

struct NavigationBarButton: View {
  
  private let type: Kind
  enum Kind {
    case ticket(Int)
    case notification(Int)
    case profile
    
    var image: Image {
      switch self {
      case .ticket:
        return Image(systemName: "ticket")
        
      case .notification:
        return Image(systemName: "bell")
        
      case .profile:
        return Image(systemName: "person")
      }
    }
  }
  
  init(type: Kind) {
    self.type = type
  }
  
  var body: some View {
    ZStack {
      imageButton
      switch type {
      case let .ticket(count), let .notification(count):
        badge(count: count)
        
      case .profile:
        Spacer()
      }
    }
  }
}

struct NavigationBarButton_Previews: PreviewProvider {
  static var previews: some View {
    NavigationBarButton(type: .ticket(24))
      .previewLayout(.sizeThatFits)
  }
}

extension NavigationBarButton {
  
  var imageButton: some View {
    Button {
      print("tapped")
    } label: {
      type.image
        .font(.title3)
        .fontWeight(.bold)
        .foregroundColor(.black)
    }
  }
  
  private func badge(count: Int) -> some View {
    Text("\(count)")
      .foregroundColor(.white)
      .font(.caption2)
      .fontWeight(.bold)
      .padding(.horizontal, 4)
      .padding(.vertical, 2)
      .background(.red)
      .clipShape(Capsule())
      .offset(x: 10, y: -10)
  }
}
