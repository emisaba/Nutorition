import UIKit

struct RecipeCreateViewModel {
    let recipeDetaileType: RecipeDetaileType
    var indexPath: IndexPath
    
    var isIngredientImageHidden: Bool {
        return recipeDetaileType != .ingredient
    }
    
    var isIngredientNameButtonIsHidden: Bool {
        return recipeDetaileType != .ingredient
    }
    
    var isIngredientAmountLabelHidden: Bool {
        return recipeDetaileType != .ingredient
    }
    
    var isIngredientGramLabelHidden: Bool {
        return recipeDetaileType != .ingredient
    }
    
    var isNameTextFieldHidden: Bool {
        return recipeDetaileType != .spice
    }
    
    var isSpiceAmountLabelHidden: Bool {
        return recipeDetaileType != .spice
    }
    
    var isSpiceGramLabelHidden: Bool {
        return recipeDetaileType != .spice
    }
    
    var isStepNumberLabelHidden: Bool {
        return recipeDetaileType != .step
    }
    
    var isDescriptionTextVieweHidden: Bool {
        return recipeDetaileType != .step
    }
    
    var isDescripeionPlaceholderHidden: Bool {
        return recipeDetaileType != .step
    }
    
    var isDidFinishDescriptionButtonHidden: Bool {
        return recipeDetaileType != .step
    }
    
    init(recipeDetaileType: RecipeDetaileType, indexPath: IndexPath) {
        self.recipeDetaileType = recipeDetaileType
        self.indexPath = indexPath
    }
}
