import UIKit

struct Ingredient {
    let ingredientID: String
    let imageUrl: String
    let name: String
    let amount: String
    
    init(data: [String: Any]) {
        self.ingredientID = data["ingredientID"] as? String ?? ""
        self.imageUrl = data["imageUrl"] as? String ?? ""
        self.name = data["name"] as? String ?? ""
        self.amount = data["amount"] as? String ?? ""
    }
}
