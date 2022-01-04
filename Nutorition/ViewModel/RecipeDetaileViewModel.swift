import UIKit

struct RecipeDetaileViewModel {
    let recipeDetaile: RecipeDetaile
    let indexPath: IndexPath
    let recipeDetaileType: RecipeDetaileType
    
    var ingredient: Ingredient? {
        guard let ingredient = recipeDetaile.ingredient else { return nil }
        return ingredient
    }
    
    var spice: Spice? {
        guard let spice = recipeDetaile.spice else { return nil }
        return spice
    }
    
    var step: Step? {
        guard let step = recipeDetaile.step else { return nil }
        return step
    }
    
    var ingredientImageUrl: URL? {
        if indexPath.section != 0 { return nil }
        guard let imageUrl = ingredient?.imageUrls[indexPath.row] else { return nil }
        return URL(string: imageUrl)
    }
    
    var shouldHideIngredientImage: Bool {
        return recipeDetaileType == .ingredient ? false : true
    }
    
    var ingredientName: String {
        if indexPath.section != 0 { return "" }
        guard let name = ingredient?.names[indexPath.row] else { return "" }
        return name
    }
    
    var shouldHideIngredientName: Bool {
        return recipeDetaileType == .ingredient ? false : true
    }
    
    var ingredientAmount: String {
        if indexPath.section != 0 { return "" }
        guard let amount = ingredient?.amounts[indexPath.row] else { return "" }
        return amount
    }
    
    var shouldHideIngredientAmount: Bool {
        return recipeDetaileType == .ingredient ? false : true
    }
    
    var spiceName: String {
        if indexPath.section != 1 { return "" }
        guard let name = spice?.names[indexPath.row] else { return "" }
        return name
    }
    
    var shouldHideSpiceName: Bool {
        return recipeDetaileType == .spice ? false : true
    }
    
    var spiceAmount: String {
        if indexPath.section != 1 { return "" }
        guard let amount = spice?.amounts[indexPath.row] else { return "" }
        return amount
    }
    
    var shouldHideSpiceAmount: Bool {
        return recipeDetaileType == .spice ? false : true
    }
    
    var stepNumber: String {
        if indexPath.section != 2 { return "" }
        return "\(indexPath.row + 1)"
    }
    
    var shouldHideStepNumber: Bool {
        return recipeDetaileType == .step ? false : true
    }
    
    var stepDescription: String {
        if indexPath.section != 2 { return "" }
        guard let description = step?.descriptions[indexPath.row] else { return "" }
        return description
    }
    
    var shouldHideStepDescription: Bool {
        return recipeDetaileType == .step ? false : true
    }
    
    init(recipeDetaile: RecipeDetaile, indexPath: IndexPath, recipeDetaileType: RecipeDetaileType) {
        self.recipeDetaile = recipeDetaile
        self.indexPath = indexPath
        self.recipeDetaileType = recipeDetaileType
    }
}
