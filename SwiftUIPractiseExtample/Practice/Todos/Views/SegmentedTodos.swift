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
    @StateObject private var vm = SegmentedTodosVM()
    
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
        ScrollView(.vertical) {
            LazyVGrid(columns: columns) {
                ForEach(vm.todoResponse.indices) { index in
                    TodosGridComponent(model: vm.todoResponse[index])
                }
            }
            .padding(20)
        }
    }
}
