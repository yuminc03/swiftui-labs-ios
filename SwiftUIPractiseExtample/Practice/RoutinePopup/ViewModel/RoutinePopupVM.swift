//
//  RoutinePopupVM.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/05/29.
//

import Foundation

final class RoutinePopupVM: ObservableObject {
    /// 습관관리 팝업이 보이는 상태인지 여부
    @Published var isRoutinePopupShow: Bool = false
    /// 습관관리 버튼이 활성화 상태인지 상태 (true = 활성화상태)
    @Published var routineButtonsStatus = Array(repeating: true, count: 6)
    /// 현재 눌린 버튼 index
    @Published var currentSelectedIndex: Int?
    /// 비활성화 팝업이 보이는지 여부
    @Published var isAlertShow: Bool = false
    
}
