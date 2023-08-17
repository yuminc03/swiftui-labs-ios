//
//  SpecialCharacterView.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/14.
//

import SwiftUI

struct SpecialCharacterView: View {
    
    let character: String
    let backgroundColor: Color
    
    var body: some View {
        Circle()
            .frame(
                width: (UIScreen.main.bounds.width - 120) / 3,
                height: (UIScreen.main.bounds.width - 120) / 3
            )
            .foregroundColor(backgroundColor)
            .overlay(alignment: .center) {
                Text(character)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            }
    }
}

struct SpecialCharacterView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            SpecialCharacterView(
                character: "﹡",
                backgroundColor: Color("gray_D8D8D8")
            )
        }
        .ignoresSafeArea()
    }
}
