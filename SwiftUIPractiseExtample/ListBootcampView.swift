//
//  ListBootcampView.swift
//  SwiftuiThinkingBootcamp
//
//  Created by Yumin Chu on 2023/05/07.
//

import SwiftUI

struct ListBootcampView: View {

    @State var fruits: [String] = [
        "apple", "orange", "banana", "peach"
    ]
    @State var veggies: [String] = [
        "carrot", "tomato", "cabbage"
    ]
    
    var body: some View {
        NavigationView {
            List {
                Section(
                    header:
                        HStack {
                            Text("Fruits")
                            Image(systemName: "flame.fill")
                        }
                        .font(.headline)
                        .foregroundColor(.pink)
                ) {
                    ForEach(0 ..< 500) { num in
                        Text("\(num)")
                            .font(.caption)
                            .foregroundColor(.black)
                            .padding(.vertical, 10)
                        if num == 2 || num == 5 {
                            Image(systemName: "heart.fill")
                        }
                    }
//                    ForEach(fruits, id: \.self) { fruit in // \.self == id
//                        Text(fruit.capitalized)
//                            .font(.caption)
//                            .foregroundColor(.white)
//                            .padding(.vertical)
//                    }
//                    .onDelete(perform: delete)
//                    .onMove(perform: move)
//                    .listRowBackground(Color.orange)
                }
                
//                Section(header: Text("Veggies")) {
//                    ForEach(veggies, id: \.self) { veggie in
//                        Text(veggie.capitalized) // 첫글자를 대문자로 표시
//                    }
//                }
            }
            .accentColor(.purple)
//            // iOS, iPad의 스타일이 서로 다를 수 있어 테스트를 해야함
//            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Grocery List")
            .navigationBarItems(
                leading: EditButton(),
                trailing: addButton
            )
        }
        .accentColor(.purple) // view의 강조 색상 변경
    }
    
    private var addButton: some View {
        Button("Add", action: {
            add()
        })
    }
    
    private func delete(indexSet: IndexSet) {
        fruits.remove(atOffsets: indexSet)
    }
    
    private func move(indexSet: IndexSet, newOffset: Int) {
        fruits.move(fromOffsets: indexSet, toOffset: newOffset)
    }
    
    private func add() {
        fruits.append("StrewBerry")
    }
}

struct ListBootcampView_Previews: PreviewProvider {
    static var previews: some View {
        ListBootcampView()
    }
}
