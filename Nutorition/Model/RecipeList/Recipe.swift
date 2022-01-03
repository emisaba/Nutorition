import UIKit

struct Recipe {
    let mainImageUrl: String
    let title: String
    let recipeID: String
    let ingredientID: String
    let foodIds: [String]
    let spiceID: String
    let stepID: String
    let foodSum: [String: Double]
    
    init(data: [String: Any]) {
        self.mainImageUrl = data["mainImageUrl"] as? String ?? ""
        self.title = data["title"] as? String ?? ""
        self.recipeID = data["recipeID"] as? String ?? ""
        self.ingredientID = data["ingredientID"] as? String ?? ""
        self.foodIds = data["foodIds"] as? [String] ?? [""]
        self.spiceID = data["spiceID"] as? String ?? ""
        self.stepID = data["stepID"] as? String ?? ""
        self.foodSum = data["foodSum"] as? [String: Double] ?? [:]
    }
}
