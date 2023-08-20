//
//  NumberView.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/14.
//

import SwiftUI

struct NumberView: View {
    
    let numberText: String
    let bottomText: String
    let backgroundColor: Color
    let action: () -> Void
    
    init(
        numberText: String,
        bottomText: String,
        backgroundColor: Color = Color("gray_D8D8D8"),
        action: @escaping () -> Void
    ) {
        self.numberText = numberText
        self.bottomText = bottomText
        self.backgroundColor = backgroundColor
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Circle()
                    .frame(
                        width: (UIScreen.main.bounds.width - 120) / 3,
                        height: (UIScreen.main.bounds.width - 120) / 3
                    )
                    .foregroundColor(backgroundColor)
                    .overlay(alignment: .center) {
                        VStack {
                            Text(numberText)
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                            if bottomText.isEmpty == false {
                                Text(bottomText)
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                            }
                        }
                        .padding()
                    }
            }
        }
    }
}

struct NumberView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            NumberView(numberText: "2", bottomText: "A B C") {
                print("action")
            }
        }
        .ignoresSafeArea()
    }
}
