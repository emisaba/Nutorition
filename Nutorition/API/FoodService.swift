import UIKit
import Firebase

struct FoodService {
    
    static func uploadFoodInfo(food: Food, completion: @escaping (String) -> Void) {
        
        let ref = COLLECTION_FOODS.document()
        let foodID = ref.documentID
        
        let protein = food.protein
        let calcium = food.calcium
        let iron = food.iron
        let vitaminA = food.vitaminA
        let vitaminB = food.vitaminB
        let vitaminC = food.vitaminC
        let vitaminE = food.vitaminE
        let vitaminD = food.vitaminD
        
        let data: [String: String] = ["foodID": foodID,
                                      "protein": protein,
                                      "calcium": calcium,
                                      "iron": iron,
                                      "vitaminA": vitaminA,
                                      "vitaminB": vitaminB,
                                      "vitaminC": vitaminC,
                                      "vitaminE": vitaminE,
                                      "vitaminD": vitaminD]
        
        ref.setData(data) { error in
            if let error = error {
                print("failed to upload food info: \(error.localizedDescription)")
                return
            }
            
            completion(foodID)
        }
    }
    
    static func fetchFoodInfo(completion: @escaping (([FoodItem]) -> Void)) {
        COLLECTION_FOODS.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            
            let foodItem = documents.map { FoodItem(dictionary: $0.data()) }
            completion(foodItem)
        }
    }
}
