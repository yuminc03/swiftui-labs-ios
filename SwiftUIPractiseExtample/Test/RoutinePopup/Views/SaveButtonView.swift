//
//  SaveButtonView.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/05/29.
//

import SwiftUI

/// 저장하기 button을 포함하는 view
struct SaveButtonView: View {
    @EnvironmentObject private var vm: RoutinePopupVM
    
    var body: some View {
        Button("저장하기") {
            vm.isRoutinePopupShow.toggle()
        }
        .foregroundColor(.white)
        .fontWeight(.medium)
        .frame(height: 64)
        .frame(maxWidth: UIScreen.main.bounds.width - 80)
        .background(Color("green_07D329"))
        .cornerRadius(20)
    }
}


struct SaveButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SaveButtonView()
            .environmentObject(RoutinePopupVM())
    }
}
