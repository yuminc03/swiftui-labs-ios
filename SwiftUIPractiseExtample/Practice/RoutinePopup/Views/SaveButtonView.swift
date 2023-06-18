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
    @AppStorage("water") var isWaterEnabled: Bool?
    @AppStorage("stretch") var isStretchEnabled: Bool?
    @AppStorage("cardio") var isCardioEnabled: Bool?
    @AppStorage("muscle") var isMuscleEnabled: Bool?
    @AppStorage("drinking") var isDrinkingEnabled: Bool?
    @AppStorage("smoking") var isSmokingEnabled: Bool?
    
    var body: some View {
        Button("저장하기") {
            isWaterEnabled = vm.routineButtonsStatus[0]
            isStretchEnabled = vm.routineButtonsStatus[1]
            isCardioEnabled = vm.routineButtonsStatus[2]
            isMuscleEnabled = vm.routineButtonsStatus[3]
            isDrinkingEnabled = vm.routineButtonsStatus[4]
            isSmokingEnabled = vm.routineButtonsStatus[5]
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
