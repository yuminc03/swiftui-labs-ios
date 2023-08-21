//
//  SettingsItemView.swift
//  Settings
//
//  Created by Yumin Chu on 2023/08/20.
//

import SwiftUI

struct SettingsRow: View {
    
    private let setting: SettingsModel
    
    init(
        setting: SettingsModel
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
        .background(Color.white)
    }
}

struct SettingsRow_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            SettingsRow(
                setting: SettingsModel(
                    id: UUID(),
                    imageName: "swift",
                    iconColor: .red,
                    title: "title",
                    rightText: "text"
                )
            )
        }
        .ignoresSafeArea()
    }
}

extension SettingsRow {
    
    private var icon: some View {
        RoundedRectangle(cornerRadius: 8)
            .foregroundColor(setting.iconColor)
            .frame(width: 40, height: 40)
            .overlay {
                Image(systemName: setting.imageName)
                    .font(.title2)
                    .foregroundColor(.white)
            }
    }
    
    private var contents: some View {
        Text(setting.title)
            .font(.title3)
            .foregroundColor(.black)
    }
    
    private var rightContents: some View {
        Text(setting.rightText)
            .font(.title3)
            .foregroundColor(.gray)
    }
}
