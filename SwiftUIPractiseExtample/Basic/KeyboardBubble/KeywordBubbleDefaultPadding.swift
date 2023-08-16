//
//  KeywordBubbleDefaultPadding.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/16.
//

import SwiftUI

struct KeywordBubbleDefaultPadding: View {
    let keyword: String
    let symbol: String
    var body: some View {
        Label(keyword, systemImage: symbol)
            .font(.title)
            .foregroundColor(.white)
            .padding()
            .background(.purple.opacity(0.75), in: Capsule())
    }
}

struct KeywordBubbleDefaultPadding_Previews: PreviewProvider {
    static let keywords = ["chives", "fern-leaf lavender"]
    static var previews: some View {
        VStack {
            ForEach(keywords, id: \.self) {
                KeywordBubbleDefaultPadding(keyword: $0, symbol: "leaf")
            }
        }
    }
}
