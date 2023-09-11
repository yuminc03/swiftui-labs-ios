//
//  CustomPopupView.swift
//  DesignSystem
//
//  Created by Yumin Chu on 2023/09/10.
//

import SwiftUI

struct CustomPopupView: View {
  
//  private let popupTitle: String
//  private let popupContents: String
//  private let description: String
//  private let leftButtonTitle: String
//  private let rightButtonTitle: String
  @State private var popupBackgroundOpacity = 0.0
  
  var body: some View {
    ZStack {
      Color.gray.opacity(popupBackgroundOpacity)
        .ignoresSafeArea()
      VStack(spacing: 50) {
        title
        contents
        HStack(spacing: 10) {
          cancelButton
          confirmButton
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
      .onAppear {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
          self.popupBackgroundOpacity = 0.6
        }
      }
      .animation(.linear(duration: 1), value: popupBackgroundOpacity)
    }
  }
}

struct CustomPopupView_Previews: PreviewProvider {
  static var previews: some View {
    CustomPopupView()
  }
}

extension CustomPopupView {
  var title: some View {
    Text("안내")
      .foregroundColor(.gray)
  }
  
  var contents: some View {
    Text("내용")
  }
  
  var cancelButton: some View {
    Button("취소") {
      
    }
    .customButton(backgroundColor: Color("gray_B7B7B7"))
  }
  
  var confirmButton: some View {
    Button("확인") {
      
    }
    .customButton(backgroundColor: Color("green_07D329"))
  }
}
