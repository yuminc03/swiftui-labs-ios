//
//  RootView.swift
//  DesignSystem
//
//  Created by Yumin Chu on 2023/09/10.
//

import SwiftUI

struct RootView: View {
  
  @State private var isShowTreatmentAlert = false
  @State private var isShowChangeTreatmentConfirm = false
  @State private var isShowAlertWithDescription = false
  @State private var sampleText = ""
  
  var body: some View {
    ZStack {
      VStack(spacing: 20) {
        VStack(spacing: 10) {
          PrimaryButton {
            
          }
          HStack(spacing: 10) {
            PrimaryButton(
              title: "취소",
              backgroundColor: Color("gray_B0B0B0"),
              disableColor: Color("gray_909090")
            ) {
              
            }
            PrimaryButton(
              title: "확인",
              disableColor: Color("gray_909090")
            ) {
              
            }
            .disabled(sampleText.isEmpty)
          }
          PrimaryButton(title: "저장하기", backgroundColor: .blue) {
            
          }
        }
        .padding(.bottom, 50)
        showPopupButton(title: "Alert 보이기") {
          isShowTreatmentAlert = true
        }
        showPopupButton(title: "Confirm 보이기") {
          isShowChangeTreatmentConfirm = true
        }
        showPopupButton(title: "추가 설명이 있는 Alert 보이기") {
          isShowAlertWithDescription = true
        }
      }
      .padding(.horizontal, 20)
      .customAlert(
        isPresented: $isShowTreatmentAlert,
        title: "진료안내",
        contents: "설정중이던 진료조건을 임시저장할까요?"
      ) {
        isShowTreatmentAlert = false
      } secondaryButtonAction: {
        isShowTreatmentAlert = false
      }
      .customConfirm(
        isPresented: $isShowChangeTreatmentConfirm,
        contents: "진료과목을 변경하시면 선생님을\n다시 선택하고 예약을 진행하셔야 합니다\n그래도 변경하시겠습니까?"
      ) {
        isShowChangeTreatmentConfirm = false
      }
      .customAlert(
        isPresented: $isShowAlertWithDescription,
        title: "배송선택",
        contents: "약 수령방법을\n당일배송으로 선택하시겠습니까?",
        description: "약 3시간 이내 배송"
      ) {
        isShowAlertWithDescription = false
      } secondaryButtonAction: {
        isShowAlertWithDescription = false
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
    Button {
      action()
    } label: {
      Text(title)
        .customButtonStyle(backgroundColor: Color("green_07D329"))
        .foregroundColor(.white)
    }
  }
}
