//
//  RootView.swift
//  DesignSystem
//
//  Created by Yumin Chu on 2023/09/10.
//

import SwiftUI

struct RootView: View {
  
  @State private var isShowTreatmentAlert = false
  
  var body: some View {
    ZStack {
      VStack(spacing: 20) {
        showPopupButton(title: "Alert 보이기") {
          isShowTreatmentAlert = true
        }
        showPopupButton(title: "Confirm 보이기") {
          
        }
        showPopupButton(title: "추가 설명이 있는 Alert 보이기") {
          
        }
      }
      .customAlert(
        isPresented: $isShowTreatmentAlert,
        title: "진료안내",
        contents: "설정중이던 진료조건을 임시저장할까요?"
      ) {
        isShowTreatmentAlert = false
      } secondaryButtonAction: {
        isShowTreatmentAlert = false
      }
    }
  }
}

struct RootView_Previews: PreviewProvider {
  static var previews: some View {
    RootView()
  }
}

extension RootView {
  
  private func showPopupButton(
    title: String,
    action: @escaping () -> Void
  ) -> some View {
    Button(title) {
      action()
    }
    .fontWeight(.semibold)
    .foregroundColor(.white)
    .padding(20)
    .background(Color("green_07D329"))
    .cornerRadius(10)
  }
}
