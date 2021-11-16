import UIKit

struct FoodItem {
    let foodName: String
    let foodImageUrl: String
    let foodCategory: String
    let amount: [String: String]
    
    init(dictionary: [String: Any]) {
        self.foodName = dictionary["foodName"] as? String ?? ""
        self.foodImageUrl = dictionary["foodImageUrl"] as? String ?? ""
        self.foodCategory = dictionary["foodCategory"] as? String ?? ""
        self.amount = dictionary["amount"] as? [String: String] ?? [:]
    }
}
