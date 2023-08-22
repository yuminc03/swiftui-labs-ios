//
//  SettingsItemView.swift
//  Settings
//
//  Created by Yumin Chu on 2023/08/20.
//

import SwiftUI

struct SettingsRow: View {
    
    private let setting: SettingItem
    
    init(
        setting: SettingItem
    ) {
        self.setting = setting
    }
    
    var body: some View {
        HStack {
            icon
                .padding(.trailing, 10)
            contents
            Spacer()
            rightContents
        }
    }
}

struct SettingsRow_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            SettingsRow(
                setting: SettingItem.airPods
            )
            .background(Color.white)
        }
        .ignoresSafeArea()
    }
}

extension SettingsRow {
    
    private var icon: some View {
        RoundedRectangle(cornerRadius: 8)
            .foregroundColor(setting.iconColor)
            .frame(width: 30, height: 30)
            .overlay {
                Image(systemName: setting.imageName)
                    .font(.body)
                    .foregroundColor(.white)
            }
    }
    
    private var contents: some View {
        Text(setting.title)
            .font(.body)
            .foregroundColor(.black)
    }
    
    private var rightContents: some View {
        Text(setting.rightText)
            .font(.body)
            .foregroundColor(.gray)
    }
}
