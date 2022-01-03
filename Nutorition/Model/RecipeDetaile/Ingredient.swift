import UIKit

struct Ingredient {
    let ingredientID: String
    let imageUrls: [String]
    let names: [String]
    let amounts: [String]
    let foodIds: [String]
    
    init(data: [String: Any]) {
        self.ingredientID = data["ingredientID"] as? String ?? ""
        self.imageUrls = data["imageUrls"] as? [String] ?? [""]
        self.names = data["names"] as? [String] ?? [""]
        self.amounts = data["amounts"] as? [String] ?? [""]
        self.foodIds = data["foodIds"] as? [String] ?? [""]
    }
}

struct IngredientDetaile {
    let ingredientID: String
    let imageUrl: String
    let foodID: String
    let name: String
    let amount: String
    let protein: String
    let calcium: String
    let iron: String
    let vitaminA: String
    let vitaminB: String
    let vitaminC: String
    let vitaminD: String
    let vitaminE: String
    
    init(data: [String: Any]) {
        self.ingredientID = data["ingredientID"] as? String ?? ""
        self.imageUrl = data["imageUrl"] as? String ?? ""
        self.foodID = data["foodID"] as? String ?? ""
        self.name = data["name"] as? String ?? ""
        self.amount = data["amount"] as? String ?? ""
        self.protein = data["protein"] as? String ?? ""
        self.calcium = data["calcium"] as? String ?? ""
        self.iron = data["iron"] as? String ?? ""
        self.vitaminA = data["vitaminA"] as? String ?? ""
        self.vitaminB = data["vitaminB"] as? String ?? ""
        self.vitaminC = data["vitaminC"] as? String ?? ""
        self.vitaminD = data["vitaminD"] as? String ?? ""
        self.vitaminE = data["vitaminE"] as? String ?? ""
    }
}

struct Nutrition {
    let foodID: String
    let imageUrl: String
    let foodName: String
    let amount: String
    let protein: String
    let calcium: String
    let iron: String
    let vitaminA: String
    let vitaminB: String
    let vitaminC: String
    let vitaminD: String
    let vitaminE: String
    
    init(data: [String: Any]) {
        self.foodID = data["foodID"] as? String ?? ""
        self.imageUrl = data["imageUrl"] as? String ?? ""
        self.foodName = data["foodName"] as? String ?? ""
        self.amount = data["amount"] as? String ?? ""
        self.protein = data["protein"] as? String ?? ""
        self.calcium = data["calcium"] as? String ?? ""
        self.iron = data["iron"] as? String ?? ""
        self.vitaminA = data["vitaminA"] as? String ?? ""
        self.vitaminB = data["vitaminB"] as? String ?? ""
        self.vitaminC = data["vitaminC"] as? String ?? ""
        self.vitaminD = data["vitaminD"] as? String ?? ""
        self.vitaminE = data["vitaminE"] as? String ?? ""
    }
}
