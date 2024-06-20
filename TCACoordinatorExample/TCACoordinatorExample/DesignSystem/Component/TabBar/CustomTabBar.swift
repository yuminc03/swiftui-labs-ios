//
//  CustomTabBar.swift
//  TCACoordinatorExample
//
//  Created by LS-NOTE-00106 on 6/20/24.
//

import SwiftUI

struct CustomTabBar: View {
  @Binding var index: Tab
  
  var body: some View {
    HStack(spacing: 20) {
      ForEach(Tab.allCases, id: \.self) { item in
        VStack(spacing: 4) {
          Image(systemName: index == item ? item.selectedIcon : item.icon)
            .resizable()
            .frame(width: 30, height: 30)
          Text(item.title)
            .font(.system(size: 12))
        }
        .foregroundColor(index == item ? .blue : .black)
        .frame(maxWidth: .infinity)
        .onTapGesture {
          if index != item {
            index = item
          }
        }
      }
    }
    .padding(.horizontal, 20)
    .animation(.easeIn, value: index)
    .frame(height: 60)
    .background(.white)
  }
}

#Preview {
  CustomTabBar(index: .constant(.home))
}
