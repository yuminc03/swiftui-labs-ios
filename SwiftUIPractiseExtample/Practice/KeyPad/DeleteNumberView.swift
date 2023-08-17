//
//  DeleteNumberView.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/17.
//

import SwiftUI

struct DeleteNumberView: View {
    var body: some View {
        Image(systemName: "delete.left.fill")
            .symbolRenderingMode(.hierarchical)
            .resizable()
            .scaledToFit()
            .frame(width: 40, height: 40)
    }
}

struct DeleteNumberView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteNumberView()
    }
}
