//
//  SafeAreaRegionsExample.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/05/06.
//

import SwiftUI

struct SafeAreaRegionsExample: View {
    @State private var name: String = ""
    
    var body: some View {
        ZStack {
            Color.purple
            
            VStack {
                Text("Welcome")
                    .font(.title)
                
                Spacer()
                
                HStack {
                    TextField(text: $name) {
                        Text("name ...")
                    }
                    .textFieldStyle(.roundedBorder)
                    
                    Button(action: {}) {
                        Image(systemName: "arrow.right.square")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                Text("Welcome")
                    .font(.title)
                    .foregroundColor(.white)
            }
        }
        .ignoresSafeArea(.all)
    }
}

struct SafeAreaRegionsExample_Previews: PreviewProvider {
    static var previews: some View {
        SafeAreaRegionsExample()
    }
}
