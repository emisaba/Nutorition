import UIKit

struct FoodListViewModel {
    let food: FoodItem
    var imageUrl: URL? {
        return URL(string: food.foodImageUrl)
    }
    
    init(food: FoodItem) {
        self.food = food
    }
}
