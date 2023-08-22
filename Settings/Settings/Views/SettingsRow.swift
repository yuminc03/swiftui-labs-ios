//
//  SettingsItemView.swift
//  Settings
//
//  Created by Yumin Chu on 2023/08/20.
//

import SwiftUI

struct SettingsRow: View {
    
    private let item: SettingItem
    
    init(
        item: SettingItem
    ) {
        self.item = item
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
        VStack {
            SettingsRow(item: .airPods)
            SettingsRow(item: .airplane)
            SettingsRow(item: .wifi)
        }
        .previewLayout(.sizeThatFits)
    }
}

private extension SettingsRow {
    
    var icon: some View {
        Image(systemName: item.imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 20, height: 20)
            .foregroundColor(.white)
            .padding(5)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(item.iconColor)
            }
    }
    
    var contents: some View {
        Text(item.title)
            .font(.body)
            .foregroundColor(.black)
    }
    
    var rightContents: some View {
        Text(item.rightText ?? "")
            .font(.body)
            .foregroundColor(.gray)
    }
}
