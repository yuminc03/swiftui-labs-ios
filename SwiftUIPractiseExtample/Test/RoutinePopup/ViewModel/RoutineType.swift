//
//  File.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/05/29.
//

import Foundation

/// 습관관리 Type
enum RoutineType: Int, CaseIterable {
    case water
    case stretching
    case cardio
    case musule
    case drinking
    case smoking
    
    var title: String {
        switch self {
        case .water:
            return "물 마시기"
            
        case .stretching:
            return "스트레칭"
            
        case .cardio:
            return "유산소 운동"
            
        case .musule:
            return "근력 운동"
            
        case .drinking:
            return "금주하기"
            
        case .smoking:
            return "금연하기"
        }
    }
    
    var imageName: String {
        switch self {
        case .water:
            return "cup.and.saucer.fill"
            
        case .stretching:
            return "rectangle.fill"
            
        case .cardio:
            return "figure.walk"
            
        case .musule:
            return "flame.fill"
            
        case .drinking:
            return "drop.circle.fill"
            
        case .smoking:
            return "smoke.fill"
        }
    }
}
