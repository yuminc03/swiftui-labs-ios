//
//  CallGreenView.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/17.
//

import SwiftUI

struct CallGreenView: View {
    var body: some View {
        Image(systemName: "phone.circle.fill")
            .resizable()
            .frame(
                width: (UIScreen.main.bounds.width - 120) / 3,
                height: (UIScreen.main.bounds.width - 120) / 3
            )
            .symbolRenderingMode(.multicolor)
    }
}

struct CallGreenView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            CallGreenView()
        }
        .ignoresSafeArea()
    }
}
