//
//  TextFieldExampoe.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/05/06.
//

import SwiftUI

struct TextFieldExampleView: View {
    
    @State private var userNameText = PersonNameComponents()
    
    var body: some View {
        VStack {
            TextField("Input Name", value: $userNameText, format: .name(style: .medium)
            )
            .padding()
            .background(Color.gray.opacity(0.5))
            .cornerRadius(10)
            
            Text("input names: \(userNameText.debugDescription)")
        }
        .padding()
    }
}

struct SafeAreaRegionsExampleView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldExampleView()
    }
}
