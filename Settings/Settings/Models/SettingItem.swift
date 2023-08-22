//
//  SettingItem.swift
//  Settings
//
//  Created by Yumin Chu on 2023/08/20.
//

import Foundation

import SwiftUI

enum SettingItem: Identifiable, Equatable {
    case airPods
    case airplane
    case wifi
    case bluetooth
    case cellular
    case hotspot
    case vpn
    case notification
    case soundAndHaptic
    case focusMode
    case screenTime
     
    var id: String {
        return String(describing: self)
    }
    
    var imageName: String {
        switch self {
        case .airPods: return "airpodspro"
        case .airplane: return "airplane"
        case .wifi: return "wifi"
        case .bluetooth: return "wave.3.right"
        case .cellular: return "antenna.radiowaves.left.and.right"
        case .hotspot: return "personalhotspot"
        case .vpn: return "lock.fill"
        case .notification: return "bell.badge"
        case .soundAndHaptic: return "speaker.wave.3.fill"
        case .focusMode: return "moon.fill"
        case .screenTime: return "hourglass"
        }
    }
    
    var iconColor: Color {
        switch self {
        case .airPods: return .gray
        case .airplane: return .orange
        case .wifi: return .blue
        case .bluetooth: return .blue
        case .cellular: return .green
        case .hotspot: return .green
        case .vpn: return .blue
        case .notification: return .red
        case .soundAndHaptic: return .pink
        case .focusMode: return .indigo
        case .screenTime: return .indigo
        }
    }
    
    var title: String {
        switch self {
        case .airPods: return "유민의 AirPads Pro 2"
        case .airplane: return "에어플레인 모드"
        case .wifi: return "Wi-Fi"
        case .bluetooth: return "Bluetooth"
        case .cellular: return "셀룰러"
        case .hotspot: return "개인용 핫스팟"
        case .vpn: return "VPN"
        case .notification: return "알림"
        case .soundAndHaptic: return "사운드 및 햅틱"
        case .focusMode: return "집중 모드"
        case .screenTime: return "스크린 타임"
        }
    }
    
    var rightText: String {
        switch self {
        case .airPods: return ""
        case .airplane: return ""
        case .wifi: return "LS_DEV"
        case .bluetooth: return "켬"
        case .cellular: return ""
        case .hotspot: return "끔"
        case .vpn: return "연결 안 됨"
        case .notification: return ""
        case .soundAndHaptic: return ""
        case .focusMode: return ""
        case .screenTime: return ""
        }
    }
    
    static let section1: [SettingItem] = [.airPods]
    static let section2: [SettingItem] = [.airplane, .wifi, .bluetooth, .cellular, .hotspot, .vpn]
    static let section3: [SettingItem] = [.notification, .soundAndHaptic, .focusMode, .screenTime]
}
