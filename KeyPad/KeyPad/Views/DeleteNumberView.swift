//
//  DeleteNumberView.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/17.
//

import SwiftUI

struct DeleteNumberView: View {
    
    private let action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "delete.backward.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(.black)
                .symbolRenderingMode(.hierarchical)
        }
    }
}

struct DeleteNumberView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteNumberView {
            print("action")
        }
    }
}
