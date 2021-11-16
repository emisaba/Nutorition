import UIKit

struct FoodViewModel {
    let food: Food
    let categoryType: RegisterViewCategoryType
    
    var questionLabelText: String {
        return categoryType.categoryText
    }
    
    var foodImageViewIshidden: Bool {
        return categoryType == .foodImage ? false : true
    }
    
    var foodNameFieldIshidden: Bool {
        return categoryType == .foodName ? false : true
    }
    
    var amountStackViewIsHidden: Bool {
        return categoryType == .foodAmount ? false : true
    }
    
    var dropDownMenuViewIsHidden: Bool {
        return categoryType == .foodCategory ? false : true
    }
    
    var foodName: String {
        return food.food_name
    }
    
    init(food: Food, categoryTypr: RegisterViewCategoryType) {
        self.food = food
        self.categoryType = categoryTypr
    }
}
