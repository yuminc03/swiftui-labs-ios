//
//  CustomPopupView.swift
//  DesignSystem
//
//  Created by Yumin Chu on 2023/09/10.
//

import SwiftUI

struct CustomPopupView: View {
  var body: some View {
    ZStack {
      Color.gray.opacity(0.3)
        .ignoresSafeArea()
      VStack(spacing: 50) {
        Text("진료 안내")
          .foregroundColor(.gray)
        Text("설정중이던 진료조건을 임시저장할까요?")
        HStack(spacing: 10) {
          Button("취소") {
            
          }
          .padding(.vertical, 20)
          .frame(maxWidth: .infinity)
          .background(.gray)
          .cornerRadius(10)
          Button("확인") {
            
          }
          .padding(.vertical, 20)
          .frame(maxWidth: .infinity)
          .background(.green)
          .cornerRadius(10)
        }
        .foregroundColor(.white)
      }
      .font(.headline)
      .padding(20)
      .background {
        RoundedRectangle(cornerRadius: 20)
          .fill(.white)
      }
      .padding(20)
    }
  }
}

struct CustomPopupView_Previews: PreviewProvider {
  static var previews: some View {
    CustomPopupView()
  }
}

extension CustomPopupView {
  
}
