//
//  CirclularView.swift
//  SwiftUICookbook
//
//  Created by Yumin Chu on 2023/09/06.
//

import SwiftUI

struct CirclularView: View {
    var body: some View {
        Text("I am\nCircular View!")
        .multilineTextAlignment(.center)
        .padding(50)
        .foregroundColor(.white)
        .background(
          Circle()
            .fill(.blue)
            .frame(width: 200, height: 200)
        )
    }
}

struct Circlulariew_Previews: PreviewProvider {
    static var previews: some View {
        CirclularView()
    }
}
