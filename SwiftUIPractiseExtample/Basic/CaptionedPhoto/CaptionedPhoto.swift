//
//  CaptionedPhoto.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/16.
//

import SwiftUI

struct CaptionedPhoto: View {
    let assertName: String
    let captionText: String
    
    var body: some View {
        Image(assertName)
            .resizable()
            .scaledToFit()
            .overlay(alignment: .bottom) {
                Caption(text: captionText)
            }
            .clipShape(RoundedRectangle(
                cornerRadius: 10,
                style: .continuous
            ))
            .padding()
    }
}

struct CaptionedPhoto_Previews: PreviewProvider {
    static let landscapeName = "Pink_Peony"
    static let landscapeCaption = "This photo is wider than it is tall."
    static let portraitName = "Yellow_Daisy"
    static let portraitCaption = "This photo is taller than it is wide."
    static var previews: some View {
        VStack {
            CaptionedPhoto(
                assertName: portraitName, captionText: portraitCaption
            )
            CaptionedPhoto(
                assertName: landscapeName, captionText: landscapeCaption
            )
        }
    }
}

struct Caption: View {
    let text: String
    var body: some View {
        Text(text)
            .padding()
            .background(
                Color("TextContrast").opacity(0.75),
                in: RoundedRectangle(cornerRadius: 10, style: .continuous)
            )
            .padding()
    }
}
