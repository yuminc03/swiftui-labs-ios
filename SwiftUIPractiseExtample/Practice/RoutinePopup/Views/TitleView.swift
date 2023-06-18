//
//  TitleView.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/05/29.
//

import SwiftUI

/// 나의 습관관리 popup title view
struct TitleView: View {
    @EnvironmentObject private var vm: RoutinePopupVM
    
    var body: some View {
        HStack {
            Text("나의 습관관리 편집")
                .font(.title)
                .fontWeight(.bold)
            Spacer()
            Button(action: {
                vm.isRoutinePopupShow.toggle()
                vm.routineButtonsStatus = Array(repeating: true, count: 6)
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.black)
                    .font(.title2)
                    .fontWeight(.bold)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 40)
    }
}


struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView()
            .environmentObject(RoutinePopupVM())
    }
}
