//
//  ContentListView.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/17.
//

import SwiftUI

struct ContentListView: View {
    @Binding var selection: Recipe.ID?
    @EnvironmentObject private var recipeBox: RecipeBox
    @State private var recipeEditorConfig = RecipeEditorConfig()
    let selectedSidebarItem: SidebarItem
    
    var body: some View {
        RecipeListView(
            selection: $selection,
            selectedSidebarItem: selectedSidebarItem
        )
        .toolbar {
            ToolbarItem {
                Button {
                    recipeEditorConfig.presentAddRecipe(sidebarItem: selectedSidebarItem)
                } label: {
                    Image(systemName: "plus")
                }
                .sheet(
                    isPresented: $recipeEditorConfig.isPresented,
                    onDismiss: didDismissEditor
                ) {
                    RecipeEditor(config: $recipeEditorConfig)
                }
            }
        }
    }
}

extension ContentListView {
    
    private func didDismissEditor() {
        guard recipeEditorConfig.isShouldSaveChanges else { return }
        if recipeEditorConfig.recipe.isNew {
            selection = recipeBox.add(recipeEditorConfig.recipe)
        } else {
            recipeBox.update(recipeEditorConfig.recipe)
        }
    }
}
