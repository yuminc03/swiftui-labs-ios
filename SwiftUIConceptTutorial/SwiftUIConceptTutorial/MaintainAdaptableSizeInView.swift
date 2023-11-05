//
//  MaintainAda;ptableSizeInView.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/17.
//

import SwiftUI

struct MaintainAdaptableSizeInView: View {
    
    @State private var selectedItem = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 50) {
                VStack {
                    Text("Hamlet")
                        .font(.largeTitle)
                    Text("by William Shakespeare")
                        .font(.caption)
                        .italic()
                }
                
                HStack {
                    Image(systemName: "folder.badge.plus")
                    Image(systemName: "heart.circle.fill")
                    Image(systemName: "alarm")
                }
                .symbolRenderingMode(.multicolor)
                .font(.largeTitle)
                
                Label("Favorite Books", systemImage: "books.vertical")
                    .labelStyle(.titleAndIcon)
                    .font(.largeTitle)
                
                VStack {
                    HStack {
                        Picker("Choice", selection: $selectedItem) {
                            Text("Apple")
                            Text("Banana")
                            Text("Grape")
                        }
                        Button("OK") {
                            
                        }
                        .foregroundColor(.black)
                    }
                    .controlSize(.mini)
                    HStack {
                        Picker("Choice", selection: $selectedItem) {
                            Text("Apple")
                            Text("Banana")
                            Text("Grape")
                        }
                        Button("OK") {
                            
                        }
                        .foregroundColor(.black)
                    }
                    .controlSize(.large)
                }
                
                Image("Yellow_Daisy")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                
                HStack {
                    Rectangle()
                        .foregroundColor(.blue)
                    
                    Circle()
                        .foregroundColor(.orange)
                    
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .foregroundColor(.green)
                }
                .padding()
                .aspectRatio(3.0, contentMode: .fit)
            }
        }
    }
}

struct MaintainAdaptableSizeInView_Previews: PreviewProvider {
    static var previews: some View {
        MaintainAdaptableSizeInView()
    }
}
