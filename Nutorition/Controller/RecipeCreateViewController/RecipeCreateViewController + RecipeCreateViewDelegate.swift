import UIKit

struct AmountDataSum {
    let protein: Double
    let calcium: Double
    let iron: Double
    let vitaminA: Double
    let vitaminB: Double
    let vitaminC: Double
    let vitaminD: Double
    let vitaminE: Double
}

// MARK: - RecipeCreateViewDelegate

extension RecipeCreateViewController: RecipeCreateViewDelegate {
    
    func autoSave(cell: RecipeCreateViewCell) {
        addNewRow(updateCell: cell)
    }
    
    func showIngredientView(celliIndexPth: IndexPath) {
        let vc = SelectFoodViewController()
        vc.completion = { food in
            self.selectedFoodInfo = food
            self.foodInfos.append(food)
            
            let cell = self.recipeCreateView.tableView.cellForRow(at: celliIndexPth)
            guard let recipeCreateViewCell = cell as? RecipeCreateViewCell else { return }
            recipeCreateViewCell.setIngredientName(name: food.food_name)
        }
        present(vc, animated: true, completion: nil)
    }
    
    func calculateNutrition(food: Food, amount: String) {
        guard let type = updateCell?.viewModel?.recipeDetaileType, type == .ingredient else { return }
        guard let amount = Double(amount) else { return }
        
        guard let protein = Double(food.protein) else { return }
        guard let calcium = Double(food.calcium) else { return }
        guard let iron = Double(food.iron) else { return }
        guard let vitaminA = Double(food.vitaminA) else { return }
        guard let vitaminD = Double(food.vitaminD) else { return }
        guard let vitaminE = Double(food.vitaminE) else { return }
        guard let vitaminB = Double(food.vitaminB) else { return }
        guard let vitaminC = Double(food.vitaminC) else { return }
        
        let calculatedprotein = protein / 100 * amount
        let calculatedCalcium = calcium / 100  * amount
        let calculatedIron = iron / 100  * amount
        let calculatedVitaminA = vitaminA / 100  * amount
        let calculatedVitaminD = vitaminD / 100  * amount
        let calculatedVitaminE = vitaminE / 100  * amount
        let calculatedVitaminB = vitaminB / 100  * amount
        let calculatedVitaminC = vitaminC / 100  * amount
        
        let newFoodData = AmountDataSum(protein: calculatedprotein,
                                        calcium: calculatedCalcium,
                                        iron: calculatedIron,
                                        vitaminA: calculatedVitaminA,
                                        vitaminB: calculatedVitaminD,
                                        vitaminC: calculatedVitaminE,
                                        vitaminD: calculatedVitaminB,
                                        vitaminE: calculatedVitaminC)
        
        calculateAmountSum(NewFoodData: newFoodData)
    }
    
    func calculateAmountSum(NewFoodData: AmountDataSum) {
        
        let newprotein = foodSum.protein + NewFoodData.protein
        let newCalcium = foodSum.calcium + NewFoodData.protein
        let newIron = foodSum.iron + NewFoodData.iron
        let newVitaminA = foodSum.vitaminA + NewFoodData.vitaminA
        let newVitaminD = foodSum.vitaminB + NewFoodData.vitaminB
        let newVitaminE = foodSum.vitaminC + NewFoodData.vitaminC
        let newVitaminB = foodSum.vitaminD + NewFoodData.vitaminD
        let newVitaminC = foodSum.vitaminE + NewFoodData.vitaminE
        
        let amountData = ["protein": newprotein,
                          "calcium": newCalcium,
                          "iron": newIron,
                          "vitaminA": newVitaminA,
                          "vitaminB": newVitaminB,
                          "vitaminC": newVitaminC,
                          "vitaminD": newVitaminD,
                          "vitaminE": newVitaminE]
        
        recipeCreateView.graphView.amountData = amountData
        recipeCreateView.graphView.layoutIfNeeded()
        
        self.foodSum = AmountDataSum(protein: newprotein,
                                     calcium: newCalcium,
                                     iron: newIron,
                                     vitaminA: newVitaminA,
                                     vitaminB: newVitaminB,
                                     vitaminC: newVitaminC,
                                     vitaminD: newVitaminD,
                                     vitaminE: newVitaminE)
    }
    
    func showIngredientImagePicker(updateCell: RecipeCreateViewCell) {
        self.updateCell = updateCell
        
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        
        present(picker, animated: true, completion: nil)
    }
}
