//
//  SettingsItemView.swift
//  Settings
//
//  Created by Yumin Chu on 2023/08/20.
//

import SwiftUI

struct SettingsItemView: View {
    
    private let imageName: String
    private let squareColor: Color
    private let title: String
    private let rightText: String
    
    init(
        imageName: String,
        squareColor: Color,
        title: String,
        rightText: String = ""
    ) {
        self.imageName = imageName
        self.squareColor = squareColor
        self.title = title
        self.rightText = rightText
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

struct SettingsItemView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            SettingsItemView(
                imageName: "wifi",
                squareColor: .blue,
                title: "Wi-Fi",
                rightText: "켬"
            )
        }
        .ignoresSafeArea()
    }
}

extension SettingsItemView {
    
    private var icon: some View {
        RoundedRectangle(cornerRadius: 8)
            .foregroundColor(squareColor)
            .frame(width: 40, height: 40)
            .overlay {
                Image(systemName: imageName)
                    .resizable()
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 10)
            }
    }
    
    private var contents: some View {
        Text(title)
            .font(.title3)
            .foregroundColor(.black)
    }
    
    private var rightContents: some View {
        Text(rightText)
            .font(.title3)
            .foregroundColor(.gray)
    }
}
