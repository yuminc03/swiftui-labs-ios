//
//  RoutineTransitionView.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/05/29.
//

import SwiftUI

/// 나의 습관관리 popup
struct RoutineTransitionView: View {
    @EnvironmentObject private var vm: RoutinePopupVM
    
    var body: some View {
        ZStack {
            VStack {
                TitleView()
                Spacer()
                RoutineButtonsView()
                Spacer()
                SaveButtonView()
            }
            
            ZStack {
                vm.isAlertShow ? Color.black.opacity(0.3).ignoresSafeArea() : Color.clear.ignoresSafeArea()
            }
        }
        .padding(.top, 30)
        .padding(.bottom, 60)
        .background(Color.white)
        .frame(width: UIScreen.main.bounds.width, height: 500)
        .cornerRadius(20)
    }
}

struct RoutineTransitionView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            RoutineTransitionView()
                .environmentObject(RoutinePopupVM())
        }
        .ignoresSafeArea()
    }
}
