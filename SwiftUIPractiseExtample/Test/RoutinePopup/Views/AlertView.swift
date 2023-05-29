//
//  AlertView.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/05/29.
//

import SwiftUI

/// 비활성화 alert popup
struct AlertView: View {
    @EnvironmentObject private var vm: RoutinePopupVM
    let type: RoutineType
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .frame(
                    width: UIScreen.main.bounds.width,
                    height: UIScreen.main.bounds.height
                )
                .foregroundColor(.black.opacity(0.3))
                .ignoresSafeArea()
            VStack(spacing: 40) {
                Text("안내")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(.gray)
                
                VStack(spacing: 10) {
                    Text("'\(type.title)'를 비활성화 할까요?")
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundColor(Color("black_2F2F2F"))
                    
                    Text("해제 시 관리화면에 해당 위젯이 사라집니다.")
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundColor(Color("gray_C7C7C7"))
                }
                
                HStack(spacing: 10) {
                    Button("취소") {
                        vm.routineButtonsStatus[vm.currentSelectedIndex ?? 0].toggle()
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: (UIScreen.main.bounds.width - 90) / 2, height: 64)
                    .background(Color("gray_B0B0B0"))
                    .cornerRadius(15)
                    
                    Button("확인") {
                        vm.routineButtonsStatus[vm.currentSelectedIndex ?? 0] = false
                        vm.currentSelectedIndex = nil
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: (UIScreen.main.bounds.width - 90) / 2, height: 64)
                    .background(Color("green_07D329"))
                    .cornerRadius(15)
                }
            }
            .padding(.vertical, 20)
            .frame(width: UIScreen.main.bounds.width - 40)
            .background(Color.white)
            .cornerRadius(20)
        }
    }
}


struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView(type: .water)
            .environmentObject(RoutinePopupVM())
    }
}
