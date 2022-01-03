import UIKit

struct RecipeDetaileViewModel {
    let recipeDetaile: RecipeDetaile
    let indexPath: IndexPath
    let recipeDetaileType: RecipeDetaileType
    
    var ingredient: Ingredient? {
        guard let ingredient = recipeDetaile.ingredient?[indexPath.row] else { return nil }
        return ingredient
    }
    
    var spice: Spice? {
        guard let spice = recipeDetaile.spice?[indexPath.row] else { return nil }
        return spice
    }
    
    var step: Step? {
        guard let step = recipeDetaile.step?[indexPath.row] else { return nil }
        return step
    }
    
    var ingredientImageUrl: URL? {
        guard let imageUrl = ingredient?.imageUrl else { return nil }
        return URL(string: imageUrl)
    }
    
    var shouldHideIngredientImageUrl: Bool {
        return recipeDetaileType == .ingredient ? false : true
    }
    
    var ingredientName: String {
        guard let name = ingredient?.name else { return "" }
        return name
    }
    
    var shouldHideIngredientName: Bool {
        return recipeDetaileType == .ingredient ? false : true
    }
    
    var ingredientAmount: String {
        guard let amount = ingredient?.amount else { return "" }
        return amount
    }
    
    var shouldHideIngredientAmount: Bool {
        return recipeDetaileType == .ingredient ? false : true
    }
    
    var spiceName: String {
        guard let name = spice?.name else { return "" }
        return name
    }
    
    var shouldHideSpiceName: Bool {
        return recipeDetaileType == .spice ? false : true
    }
    
    var spiceAmount: String {
        guard let amount = spice?.amount else { return "" }
        return amount
    }
    
    var shouldHideSpiceAmount: Bool {
        return recipeDetaileType == .spice ? false : true
    }
    
    var stepNumber: String {
        guard let number = step?.number else { return "" }
        return number
    }
    
    var shouldHideStepNumber: Bool {
        return recipeDetaileType == .step ? false : true
    }
    
    var stepDescription: String {
        guard let description = step?.description else { return "" }
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
