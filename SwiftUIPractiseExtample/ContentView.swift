//
//  ContentView.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/04/18.
//

import SwiftUI

struct ContentView: View {
//    let attributedString = try! AttributedString(markdown: "_Hamlet_ by William Shakespeare")
    let writingImplement = "pencil"

    var body: some View {
//        Text("Hamlet")
//            .font(.title) //title 폰트 적용
        
        
//        Text("by William Shakespeare")
//           .font(.system(size: 12, weight: .light, design: .serif))
//           .italic()
        
        
//        Text(attributedString)
//            .font(.system(size: 12, weight: .light, design: .serif))
        
        
//        Text("To be, or not to be, that is the question:")
//            .frame(width: 100)
        
        
//        Text("Brevity is the soul of wit.")
//            .frame(width: 100)
//            .lineLimit(1)
        
//        Text(writingImplement)
//
//        Text(LocalizedStringKey(writingImplement))
        
//        VStack {
//            Text("Font applied to a text view")
//                .font(.largeTitle)
//            VStack {
//                Text("These two text views have the same font")
//                Text("applied to their parent view.")
//            }
//            .font(.system(size: 16, weight: .bold, design: .rounded))
//        }
        
        HStack {
            Text("Red")
                .foregroundColor(.red)
            Text("Green")
                .foregroundColor(.green)
            Text("Blue")
                .foregroundColor(.blue)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
