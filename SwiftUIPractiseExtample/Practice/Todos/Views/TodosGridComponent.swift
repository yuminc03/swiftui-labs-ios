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
        ZStack {
            VStack {
                Image(systemName: "person.fill.questionmark")
                    .resizable()
                    .foregroundColor(Color("gray_B0B0B0"))
                    .scaledToFit()
                    .padding(.horizontal, 20)
                    .padding(.top, 30)
                    .frame(height: 200)
                Text("\(model.id)")
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

struct TodosGridComponent_Previews: PreviewProvider {
    static var previews: some View {
        TodosGridComponent(model: TodoModel(userId: 0, id: 0, title: "title", completed: true))
    }
}
