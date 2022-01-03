import UIKit

struct RecipeInfo {
    let mainImage: UIImage
    let title: String
    let ingredientInfos: [IngredientInfo]
    let spiceInfos: [SpiceInfo]
    let stepInfos: [StepInfo]
    let foodInfos: [Food]
    let foodSum: AmountDataSum
}
