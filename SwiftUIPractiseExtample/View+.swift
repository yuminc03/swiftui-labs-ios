//
//  View+.swift
//  TCATutorials
//
//  Created by Yumin Chu on 2023/08/12.
//

import SwiftUI

extension View {
    
    func common() -> some View {
        self
            .font(.largeTitle)
            .padding()
            .background(Color.black.opacity(0.1))
            .cornerRadius(10)
    }
}
