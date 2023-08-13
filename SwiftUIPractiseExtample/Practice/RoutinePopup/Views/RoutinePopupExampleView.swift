//
//  ThirdExample.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/05/09.
//

import SwiftUI

struct RoutinePopupExampleView: View {
    
    @StateObject private var vm = RoutinePopupVM()
    @AppStorage("water") var isWaterEnabled: Bool?
    @AppStorage("stretch") var isStretchEnabled: Bool?
    @AppStorage("cardio") var isCardioEnabled: Bool?
    @AppStorage("muscle") var isMuscleEnabled: Bool?
    @AppStorage("drinking") var isDrinkingEnabled: Bool?
    @AppStorage("smoking") var isSmokingEnabled: Bool?
    
    var body: some View {
        ZStack {
            vm.isRoutinePopupShow ? Color.black.opacity(0.3).ignoresSafeArea() : Color.clear.ignoresSafeArea()
            
            VStack {
                Button("팝업 보이기", action: {
                    vm.routineButtonsStatus = [
                        isWaterEnabled ?? false, isStretchEnabled ?? false,
                        isCardioEnabled ?? false, isMuscleEnabled ?? false,
                        isDrinkingEnabled ?? false, isSmokingEnabled ?? false
                    ]
                    vm.isRoutinePopupShow.toggle()
                })
                .foregroundColor(.white)
                .font(.headline)
                .padding()
                .background(Color("green_07D329"))
                .cornerRadius(10)
                
                Spacer()
            }
            
            VStack {
                Spacer()
                if vm.isRoutinePopupShow {
                    RoutineTransitionView()
                        .transition(
                            .asymmetric(
                                insertion: .move(edge: .bottom),
                                removal: .move(edge: .bottom)
                            )
                        )
                        .animation(
                            .spring()
                        )
                }
            }
            
            if let currentSelectedIndex = vm.currentSelectedIndex,
               let type = RoutineType(rawValue: currentSelectedIndex),
               vm.routineButtonsStatus[currentSelectedIndex] == false {
                AlertView(type: type)
                    .animation(
                        .easeInOut,
                        value: vm.routineButtonsStatus[currentSelectedIndex]
                    )
            }
        }
        .background(Color.white)
        .ignoresSafeArea(edges: .bottom)
        .environmentObject(vm)
    }
}

struct RoutinePopupExampleView_Previews: PreviewProvider {
    static var previews: some View {
        RoutinePopupExampleView()
    }
}
