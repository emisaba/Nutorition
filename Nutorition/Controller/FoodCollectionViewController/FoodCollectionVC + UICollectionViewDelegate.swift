import UIKit

extension FoodCollectonViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? FoodCollectionViewCell else { return }
        
        guard let foodName = cell.viewModel?.food.foodName else { return }
        guard let amount = cell.viewModel?.food.amount else { return }
    
        getDataFromSelectedFood(amount: amount, name: foodName)
        getDataFromExistingFoodData()
        createNewDataFromExistingDataAndSelectedData()
    }
    
    func getDataFromSelectedFood(amount: [String: String], name: String) {
        
        guard let protein = Double(amount["protein"] ?? "") else { return }
        guard let calcium = Double(amount["calcium"] ?? "") else { return }
        guard let iron = Double(amount["iron"] ?? "") else  { return }
        guard let vitaminA = Double(amount["vitaminA"] ?? "") else { return }
        guard let vitaminD = Double(amount["vitaminD"] ?? "") else { return }
        guard let vitaminE = Double(amount["vitaminE"] ?? "") else { return }
        guard let vitaminB = Double(amount["vitaminB"] ?? "") else { return }
        guard let vitaminC = Double(amount["vitaminC"] ?? "") else { return }
        
        foodNames.append(name)
        
        proteins.append(protein)
        calciums.append(calcium)
        irons.append(iron)
        vitaminaAs.append(vitaminA)
        vitaminDs.append(vitaminD)
        vitaminEs.append(vitaminE)
        vitaminBs.append(vitaminB)
        vitaminCs.append(vitaminC)
    }
    
    func getDataFromExistingFoodData() {
        
        let existingFoodData = userDefaults.amountValue()
        if existingFoodData.count > 0 {
            proteins.append(existingFoodData["protain"] ?? 0)
            calciums.append(existingFoodData["calcium"] ?? 0)
            irons.append(existingFoodData["iron"] ?? 0)
            vitaminaAs.append(existingFoodData["vitamina"] ?? 0)
            vitaminDs.append(existingFoodData["vitamind"] ?? 0)
            vitaminEs.append(existingFoodData["vitamine"] ?? 0)
            vitaminBs.append(existingFoodData["vitaminb"] ?? 0)
            vitaminCs.append(existingFoodData["vitaminc"] ?? 0)
        }
    }
    
    func createNewDataFromExistingDataAndSelectedData() {
        let protainSum = proteins.reduce(0) { $0 + $1 }
        let calciumSum = calciums.reduce(0) { $0 + $1 }
        let ironSum = irons.reduce(0) { $0 + $1 }
        let vitaminaSum = vitaminaAs.reduce(0) { $0 + $1 }
        let vitamindSum = vitaminDs.reduce(0) { $0 + $1 }
        let vitamineSum = vitaminEs.reduce(0) { $0 + $1 }
        let vitaminbSum = vitaminBs.reduce(0) { $0 + $1 }
        let vitamincSum = vitaminCs.reduce(0) { $0 + $1 }
        
        amountData = ["protain": protainSum,
                      "calcium": calciumSum,
                      "iron": ironSum,
                      "vitamina": vitaminaSum,
                      "vitamind": vitamindSum,
                      "vitamine": vitamineSum,
                      "vitaminb": vitaminbSum,
                      "vitaminc": vitamincSum]
        
        userDefaults.setAmountValue(value: amountData)
    }
}
