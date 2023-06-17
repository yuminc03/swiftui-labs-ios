//
//  FirstExample.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/04/28.
//

import SwiftUI

struct FirstExample: View {
    var body: some View {
        VStack(spacing: 10, content: {
            HStack(spacing: 0) {
                HStack(spacing: 0) {
                    Rectangle()
                        .fill(.red)
                        .frame(width: 150, height: 220)
                    Rectangle()
                        .frame(width: 10, height: 220)
                    Rectangle()
                        .fill(.white)
                        .frame(width: 180, height: 220)
                }
            }
            HStack(spacing: 0) {
                Rectangle()
                    .fill(.white)
                    .frame(width: 150, height: 220)
                Rectangle()
                    .frame(width: 10, height: 1)
                VStack(spacing: 0) {
                    Rectangle()
                        .fill(.white)
                        .frame(width: 120, height: 190)
                    Rectangle()
                        .fill(.black)
                        .frame(width: 120, height: 10)
                    HStack(spacing: 0) {
                        Rectangle()
                            .fill(.yellow)
                            .frame(width: 70, height: 20)
                        Rectangle()
                            .frame(width: 10, height: 1)
                        Rectangle()
                            .frame(width: 40, height: 20)
                    }
                }
                Rectangle()
                    .fill(.black)
                    .frame(width: 10, height: 1)
                VStack(spacing: 0) {
                    Rectangle()
                        .fill(.blue)
                        .frame(width: 50, height: 70)
                    Rectangle()
                        .fill(.black)
                        .frame(width: 51, height: 10)
                    Rectangle()
                        .fill(.white)
                        .frame(width: 50, height: 140)
                }
            }
        })
        .background(Color.black)
    }
}

struct FirstExample_Previews: PreviewProvider {
    static var previews: some View {
        FirstExample()
            .previewLayout(.sizeThatFits)
    }
}
