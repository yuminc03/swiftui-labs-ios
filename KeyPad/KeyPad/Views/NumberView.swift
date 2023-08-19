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
    
    var body: some View {
        HStack {
            Circle()
                .frame(
                    width: (UIScreen.main.bounds.width - 120) / 3,
                    height: (UIScreen.main.bounds.width - 120) / 3
                )
                .foregroundColor(Color("gray_D8D8D8"))
                .overlay(alignment: .center) {
                    VStack {
                        Text(numberText)
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                        Text(bottomText)
                            .font(.caption)
                            .fontWeight(.semibold)
                    }
                    .padding()
                }
        }
    }
}

struct NumberView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            NumberView(numberText: "2", bottomText: "A B C")
        }
        .ignoresSafeArea()
    }
}
