import UIKit

struct RecipeDetaile {
    let mainImageUrl: String
    let title: String
    let ingredient: [IngredientDetaile]?
    let spice: [Spice]?
    let step: [Step]?
    
    init(data: [String: Any]) {
        self.mainImageUrl = data["mainImageUrl"] as? String ?? ""
        self.title = data["title"] as? String ?? ""
        self.ingredient = data["ingredient"] as? [IngredientDetaile] ?? nil
        self.spice = data["spice"] as? [Spice] ?? nil
        self.step = data["step"] as? [Step] ?? nil
    }
}

enum RecipeDetaileType: CaseIterable {
    case ingredient
    case spice
    case step
    
    var title: String {
        switch self {
        case .ingredient:
            return "材料"
        case .spice:
            return "調味料"
        case .step:
            return "手順"
        }
    }
}
