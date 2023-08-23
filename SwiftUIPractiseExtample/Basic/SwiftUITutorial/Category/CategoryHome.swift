//
//  CategoryHome.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/23.
//

import SwiftUI

struct CategoryHome: View {
  
  @EnvironmentObject var modelData: ModelData
  
    var body: some View {
      NavigationView {
        List {
          ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
            CategoryRow(categoryName: key, items: modelData.categories[key]!)
          }
        }
          .navigationTitle("Featured")
      }
    }
}

struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
        .environmentObject(ModelData())
    }
}
