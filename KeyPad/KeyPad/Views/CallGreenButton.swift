//
//  CallGreenButton.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/17.
//

import SwiftUI

struct CallGreenButton: View {
    
    private let action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "phone.circle.fill")
                .resizable()
                .frame(
                    width: (UIScreen.main.bounds.width - 120) / 3,
                    height: (UIScreen.main.bounds.width - 120) / 3
                )
                .symbolRenderingMode(.multicolor)
        }
    }
}

struct CallGreenButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            CallGreenButton {
                print("action")
            }
        }
        .ignoresSafeArea()
    }
}
