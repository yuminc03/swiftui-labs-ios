//
//  RoutineButtonsView.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/05/29.
//

import SwiftUI

/// 습관 버튼들을 포함하는 view
struct RoutineButtonsView: View {
    @EnvironmentObject private var vm: RoutinePopupVM
    
    var body: some View {
        let columns: [GridItem] = [
            GridItem(.flexible(), spacing: 20, alignment: .center),
            GridItem(.flexible(), spacing: 20, alignment: .center)
        ]
        
        return LazyVGrid(columns: columns, spacing: 10, content: {
            ForEach(RoutineType.allCases, id: \.self) {
                routineButtonView(vm: vm, type: $0)
            }
        })
        .padding(.horizontal, 40)
    }
}

struct RoutineButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineButtonsView()
            .environmentObject(RoutinePopupVM())
    }
}

extension RoutineButtonsView {
    
    /// 습관 버튼 view를 리턴하는 메서드
    private func routineButtonView(vm: RoutinePopupVM, type: RoutineType) -> some View {
        HStack(alignment: .center, spacing: 10) {
            Image(systemName: type.imageName)
                .resizable()
                .scaledToFit()
                .foregroundColor(Color("green_07D329"))
                .frame(width: 36, height: 36)
            Text(type.title)
                .font(.title3)
                .fontWeight(.medium)
                .frame(maxHeight: .infinity)
        }
        .frame(width: (UIScreen.main.bounds.width - 68) / 2 - 10, height: 76)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(
                    vm.routineButtonsStatus[type.rawValue] ? Color("green_07D329")
                    : Color("gray_D8D8D8"),
                    lineWidth: 2
                )
        )
        
        .onTapGesture {
            vm.routineButtonsStatus[type.rawValue].toggle()
            vm.currentSelectedIndex = vm.routineButtonsStatus[type.rawValue] ? nil : type.rawValue
        }
    }
}
