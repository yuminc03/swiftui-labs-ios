//
//  TodosGridComponent.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/06/20.
//

import SwiftUI

struct TodosGridComponent: View {
    
    let model: TodoModel
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .stroke(.black, lineWidth: 8)
            .frame(maxWidth: .infinity)
            .frame(height: 200)
            .overlay(alignment: .center) {
                VStack {
                    Image(systemName: "person.fill.questionmark")
                        .resizable()
                        .foregroundColor(Color("gray_B0B0B0"))
                        .scaledToFit()
                        .padding(.horizontal, 10)
                        .padding(.top, 30)
                    Text("\(model.id)")
                        .foregroundColor(.black)
                        .font(.largeTitle)
                        .fontWeight(.medium)
                    Spacer()
                }
                .padding()
            }
            .padding([.top, .bottom], 10)
    }
}

struct TodosGridComponent_Previews: PreviewProvider {
    static var previews: some View {
        TodosGridComponent(model: TodoModel(userId: 0, id: 0, title: "title", completed: true))
    }
}
