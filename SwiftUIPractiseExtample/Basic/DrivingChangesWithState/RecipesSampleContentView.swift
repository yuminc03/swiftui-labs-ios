//
//  RecipesSampleContentView.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/17.
//

import SwiftUI

struct RecipesSampleContentView: View {
    @StateObject private var recipeBox = RecipeBox(recipes: load("recipeData.json"))
    @State private var selectedSidebarItem: SidebarItem? = SidebarItem.all
    @State private var selectedRecipeID: Recipe.ID?
    
    var body: some View {
        NavigationSplitView {
            SidebarView(
                selection: $selectedSidebarItem,
                recipeBox: recipeBox
            )
        } content: {
            ContentListView(
                selection: $selectedRecipeID,
                selectedSidebarItem: selectedSidebarItem ?? SidebarItem.all
            )
        } detail: {
            NavigationDetailView(recipeId: $selectedRecipeID)
        }
        .environmentObject(recipeBox)
    }
}

struct RecipesSampleContentView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesSampleContentView()
    }
}
