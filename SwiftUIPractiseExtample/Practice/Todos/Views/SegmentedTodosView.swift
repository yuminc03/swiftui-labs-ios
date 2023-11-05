//
//  SegmentedTodosView.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/06/14.
//

import SwiftUI

struct SegmentedTodosView: View {
    
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
        GridItem(.flexible(), spacing: 30, alignment: .center),
        GridItem(.flexible(), spacing: 30, alignment: .center)
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

struct SegmentedTodosView_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedTodosView()
    }
}

extension SegmentedTodosView {
    var segmentPicker: some View {
        Picker(selection: $selection, label: Text("Picker")) {
            ForEach(filterOption.indices, id: \.self) { index in
                Text(filterOption[index])
                    .tag(filterOption[index])
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
    
    var gridView: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: columns) {
                ForEach(0 ..< vm.todos.count, id: \.self) { index in
                    TodosGridComponent(model: vm.todos[index])
                }
            }
            .padding([.leading, .trailing], 20)
        }
    }
}
