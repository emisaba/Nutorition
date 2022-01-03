import UIKit
import Firebase

struct FoodService {
    
    static func uploadFoodInfo(food: IngredientInfo, completion: @escaping (String) -> Void) {
        
        let ref = COLLECTION_FOODS.document()
        let foodID = ref.documentID
        
        let protein = food.ingredient.protein
        let calcium = food.ingredient.calcium
        let iron = food.ingredient.iron
        let vitaminA = food.ingredient.vitaminA
        let vitaminB = food.ingredient.vitaminB
        let vitaminC = food.ingredient.vitaminC
        let vitaminE = food.ingredient.vitaminE
        let vitaminD = food.ingredient.vitaminD
        
        ImageUploader.uploadFoodImage(image: food.image) { imageUrl in
            
            let data: [String: String] = ["foodName": food.name,
                                          "foodID": foodID,
                                          "imageUrl": imageUrl,
                                          "amount": food.amount,
                                          "protein": protein,
                                          "calcium": calcium,
                                          "iron": iron,
                                          "vitaminA": vitaminA,
                                          "vitaminB": vitaminB,
                                          "vitaminC": vitaminC,
                                          "vitaminD": vitaminD,
                                          "vitaminE": vitaminE]
            
            ref.setData(data) { error in
                if let error = error {
                    print("failed to upload food info: \(error.localizedDescription)")
                    return
                }
                
                completion(foodID)
            }
        }
    }
    
    static func fetchFoodInfo(completion: @escaping ([FoodItem]) -> Void) {
        COLLECTION_FOODS.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            
            let foodItem = documents.map { FoodItem(dictionary: $0.data()) }
            completion(foodItem)
        }
    }
}
