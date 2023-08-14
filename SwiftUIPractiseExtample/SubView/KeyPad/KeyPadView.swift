//
//  KeyPadView.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/14.
//

import SwiftUI

struct KeyPadView: View {
    
    var body: some View {
        VStack(alignment: .center, spacing: 100) {
            VStack {
                Text("")
                
            }
            VStack {
                HStack(spacing: 20) {
                    NumberView(numberText: "1", bottomText: "")
                    NumberView(numberText: "2", bottomText: "A B C")
                    NumberView(numberText: "3", bottomText: "D E F")
                }
                .padding(.vertical, 5)
                HStack(spacing: 20) {
                    NumberView(numberText: "4", bottomText: "G H I")
                    NumberView(numberText: "5", bottomText: "J K L")
                    NumberView(numberText: "6", bottomText: "M N O")
                }
                .padding(.vertical, 5)
                HStack(spacing: 20) {
                    NumberView(numberText: "7", bottomText: "P Q R S")
                    NumberView(numberText: "8", bottomText: "T U V")
                    NumberView(numberText: "9", bottomText: "W X Y Z")
                }
                .padding(.vertical, 5)
                HStack(spacing: 20) {
                    SpecialCharacterView(character: "﹡")
                    NumberView(numberText: "0", bottomText: "+")
                    SpecialCharacterView(character: "#")
                }
                .padding(.vertical, 5)
                HStack(spacing: 20) {
                    ZStack {
                        Image(systemName: "phone.circle.fill")
                            .resizable()
                            .frame(
                                width: (UIScreen.main.bounds.width - 120) / 3,
                                height: (UIScreen.main.bounds.width - 120) / 3
                            )
                            .symbolRenderingMode(.multicolor)
                        
                        HStack {
                            Spacer()
                            Image(systemName: "delete.left.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 30)
                                .symbolRenderingMode(.hierarchical)
                                .padding(.horizontal, (UIScreen.main.bounds.width - 120) / 5)
                        }
                    }
                }
                .padding(.vertical, 5)
            }
        }
    }
}

struct KeyPadView_Previews: PreviewProvider {
    static var previews: some View {
        KeyPadView()
    }
}
