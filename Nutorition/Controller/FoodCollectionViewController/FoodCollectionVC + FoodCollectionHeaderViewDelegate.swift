import UIKit

extension FoodCollectonViewController: FoodCollectionHeaderViewDelegate {
    
    func didTapCategoryButton(cell: FoodCollectionHeaderView, sender: UIButton) {
        
        carbons = []
        veges = []
        fruits = []
        dairies = []
        meats = []
        fishes = []
        soys = []
        
        createSelectedFoodArray(cell: cell, sender: sender)
        collectionView.reloadData()
    }
    
    func createSelectedFoodArray(cell: FoodCollectionHeaderView, sender: UIButton) {
        
        foods.forEach { food in
            
            switch sender {
            case cell.carbonButton:
                selectedFoodCategory = "carbon"
                if food.foodCategory == "carbon" { carbons.append(food) }
                
            case cell.vegeButton:
                selectedFoodCategory = "vege"
                if food.foodCategory == "vege" { veges.append(food) }
                
            case cell.fruitButton:
                selectedFoodCategory = "fruit"
                if food.foodCategory == "fruit" { fruits.append(food) }
                
            case cell.dairyButton:
                selectedFoodCategory = "dairy"
                if food.foodCategory == "fruit" { dairies.append(food) }
                
            case cell.meatButton:
                selectedFoodCategory = "meat"
                if food.foodCategory == "fruit" { meats.append(food) }
                
            case cell.fishButton:
                selectedFoodCategory = "fish"
                if food.foodCategory == "fruit" { fishes.append(food) }
                
            case cell.soyButton:
                selectedFoodCategory = "soy"
                if food.foodCategory == "fruit" { soys.append(food) }
                
            default:
                break
            }
        }
    }
}
