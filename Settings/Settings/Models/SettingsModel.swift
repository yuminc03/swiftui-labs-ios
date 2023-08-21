//
//  SettingsModel.swift
//  Settings
//
//  Created by Yumin Chu on 2023/08/20.
//

import Foundation
import SwiftUI

struct SettingsModel: Identifiable, Equatable {
    let id: UUID
    let imageName: String
    let iconColor: Color
    let title: String
    let rightText: String
}
