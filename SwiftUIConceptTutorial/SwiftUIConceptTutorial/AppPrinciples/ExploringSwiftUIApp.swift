//
//  ExploringSwiftUIApp.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/15.
//

import SwiftUI

struct ExploringSwiftUIApp: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ExploringSwiftUIApp_Previews: PreviewProvider {
    static var previews: some View {
        ExploringSwiftUIApp()
    }
}
