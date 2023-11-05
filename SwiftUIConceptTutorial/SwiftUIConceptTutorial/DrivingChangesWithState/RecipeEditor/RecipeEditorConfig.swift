//
//  RecipeEditorConfig.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/17.
//

import Foundation

struct RecipeEditorConfig {
    var recipe = Recipe.emptyRecipe()
    var isShouldSaveChanges = false
    var isPresented = false
    
    mutating func presentAddRecipe(sidebarItem: SidebarItem) {
        recipe = Recipe.emptyRecipe()


        switch sidebarItem {
        case .favorites:
            // Associate the recipe to the favorites collection.
            recipe.isFavorite = true
        case .collection(let name):
            // Associate the recipe to a custom collection.
            recipe.collections = [name]
        default:
            // Nothing else to do.
            break
        }
            
        isShouldSaveChanges = false
        isPresented = true
    }
    
    mutating func presentDeitRecipe(_ recipeToEdit: Recipe) {
        recipe = recipeToEdit
        isShouldSaveChanges = false
        isPresented = true
    }
    
    mutating func done() {
        isShouldSaveChanges = true
        isPresented = false
    }
    
    mutating func cancel() {
        isShouldSaveChanges = false
        isPresented = false
    }
}

