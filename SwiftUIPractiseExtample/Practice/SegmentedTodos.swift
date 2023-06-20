//
//  SegmentedTodos.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/06/14.
//

import SwiftUI

struct SegmentedTodos: View {
    
    enum Selection: String {
        case todos
        case photos
    }
    @State private var selection: String = Selection.todos.rawValue
    private let filterOption = [
        Selection.todos.rawValue,
        Selection.photos.rawValue
    ]
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 20, alignment: .center),
        GridItem(.flexible(), spacing: 20, alignment: .center)
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                segmentPicker
                gridView
            }
            .padding()
            .navigationTitle(
                selection == Selection.todos.rawValue ? "TODO!" : "Photo"
            )
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

extension SegmentedTodos {
    var segmentPicker: some View {
        Picker(selection: $selection, label: Text("Picker")) {
            ForEach(filterOption.indices) { index in
                Text(filterOption[index])
                    .tag(filterOption[index])
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
    
    var gridView: some View {
        VStack {
            LazyVGrid(columns: columns) {
                todoComponent
            }
            .padding(20)
        }
    }
    
    var todoComponent: some View {
        ZStack {
            VStack {
                Image(systemName: "person.fill.questionmark")
                    .resizable()
                    .foregroundColor(Color("gray_B0B0B0"))
                    .scaledToFit()
                    .padding(.horizontal, 20)
                    .padding(.top, 30)
                Text("0")
                    .foregroundColor(.black)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            RoundedRectangle(cornerRadius: 20)
                .stroke(.black, lineWidth: 10)
                .frame(height: 200)
        }
    }
}
