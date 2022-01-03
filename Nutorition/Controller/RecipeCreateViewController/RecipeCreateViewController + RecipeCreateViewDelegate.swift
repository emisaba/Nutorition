import UIKit

struct AmountDataSum {
    let protain: Double
    let calcium: Double
    let iron: Double
    let vitamina: Double
    let vitamind: Double
    let vitamine: Double
    let vitaminb: Double
    let vitaminc: Double
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
        
        guard let protain = Double(food.protein) else { return }
        guard let calcium = Double(food.calcium) else { return }
        guard let iron = Double(food.iron) else { return }
        guard let vitaminA = Double(food.vitaminA) else { return }
        guard let vitaminD = Double(food.vitaminD) else { return }
        guard let vitaminE = Double(food.vitaminE) else { return }
        guard let vitaminB = Double(food.vitaminB) else { return }
        guard let vitaminC = Double(food.vitaminC) else { return }
        
        print("###オリジナル: \(protain)")
        
        let calculatedProtain = protain / 100 * amount
        let calculatedCalcium = calcium / 100  * amount
        let calculatedIron = iron / 100  * amount
        let calculatedVitaminA = vitaminA / 100  * amount
        let calculatedVitaminD = vitaminD / 100  * amount
        let calculatedVitaminE = vitaminE / 100  * amount
        let calculatedVitaminB = vitaminB / 100  * amount
        let calculatedVitaminC = vitaminC / 100  * amount
        
        print("###オリジナル * 指定amount: \(calculatedProtain)")
        
        let newFoodData = AmountDataSum(protain: calculatedProtain,
                                        calcium: calculatedCalcium,
                                        iron: calculatedIron,
                                        vitamina: calculatedVitaminA,
                                        vitamind: calculatedVitaminD,
                                        vitamine: calculatedVitaminE,
                                        vitaminb: calculatedVitaminB,
                                        vitaminc: calculatedVitaminC)
        
        calculateAmountSum(NewFoodData: newFoodData)
    }
    
    func calculateAmountSum(NewFoodData: AmountDataSum) {
        
        let newProtain = foodSum.protain + NewFoodData.protain
        let newCalcium = foodSum.calcium + NewFoodData.protain
        let newIron = foodSum.iron + NewFoodData.iron
        let newVitaminA = foodSum.vitamina + NewFoodData.vitamina
        let newVitaminD = foodSum.vitamind + NewFoodData.vitamind
        let newVitaminE = foodSum.vitamine + NewFoodData.vitamine
        let newVitaminB = foodSum.vitaminb + NewFoodData.vitaminb
        let newVitaminC = foodSum.vitaminc + NewFoodData.vitaminc
        
        print("###大元 : \(foodSum.protain)")
        print("###オリジナル * 指定amount を大元にプラス : \(newProtain)")
        
        let amountData = ["protain": newProtain,
                          "calcium": newCalcium,
                          "iron": newIron,
                          "vitamina": newVitaminA,
                          "vitamind": newVitaminD,
                          "vitamine": newVitaminE,
                          "vitaminb": newVitaminB,
                          "vitaminc": newVitaminC]
        
        recipeCreateView.graphView.amountData = amountData
        recipeCreateView.graphView.layoutIfNeeded()
        
        self.foodSum = AmountDataSum(protain: newProtain,
                                     calcium: newCalcium,
                                     iron: newIron,
                                     vitamina: newVitaminA,
                                     vitamind: newVitaminD,
                                     vitamine: newVitaminE,
                                     vitaminb: newVitaminB,
                                     vitaminc: newVitaminC)
    }
    
    func showIngredientImagePicker(updateCell: RecipeCreateViewCell) {
        self.updateCell = updateCell
        
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        
        present(picker, animated: true, completion: nil)
    }
}
