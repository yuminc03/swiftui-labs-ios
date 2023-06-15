//
//  SegmentedTodos.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/06/14.
//

import SwiftUI

struct SegmentedTodos: View {
    
    @State private var selection: String = "todos"
    private let filterOption = ["todos", "photos"]
    
    var body: some View {
        NavigationView {
            VStack {
                Picker(selection: $selection, label: Text("Picker")) {
                    ForEach(filterOption.indices) { index in
                        Text(filterOption[index])
                            .tag(filterOption[index])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .padding()
            .navigationTitle("TODO!")
        }
    }
}

struct SecondView: View {
    var body: some View {
        VStack {
            
        }
    }
}

struct SegmentedTodos_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedTodos()
    }
}
