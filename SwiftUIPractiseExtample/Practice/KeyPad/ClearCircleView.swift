//
//  WhiteCircleView.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/17.
//

import SwiftUI

struct ClearCircleView: View {
    var body: some View {
        Circle()
            .frame(
                width: (UIScreen.main.bounds.width - 120) / 3,
                height: (UIScreen.main.bounds.width - 120) / 3
            )
            .foregroundColor(.clear)
    }
}

struct ClearCircleView_Previews: PreviewProvider {
    static var previews: some View {
        ClearCircleView()
    }
}
