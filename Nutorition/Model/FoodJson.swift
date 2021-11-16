import UIKit

struct FoodContainer: Codable {
    let foods: [Food]
}

struct Food: Codable {
    var food_name: String
    var protein: String
    var calcium: String
    var iron: String
    var vitaminA: String
    var vitaminD: String
    var vitaminE: String
    var vitaminB: String
    var vitaminC: String
}
