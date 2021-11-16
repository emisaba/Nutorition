import UIKit

struct DropDownViewModel {
    let foodType: FoodType
    
    var arrowImage: UIImage? {
        return self.foodType == .carbon ? #imageLiteral(resourceName: "arrow") : nil
    }
    
    init(foodType: FoodType) {
        self.foodType = foodType
    }
}
