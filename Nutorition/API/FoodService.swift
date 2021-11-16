import UIKit
import Firebase

struct  FoodInfo {
    let foodImage: UIImage
    let foodName: String
    let amount: FoodAmount
    let foodCategory: String
}

struct FoodAmount {
    let protein: String
    let calcium: String
    let iron: String
    let vitaminA: String
    let vitaminD: String
    let vitaminE: String
    let vitaminB: String
    let vitaminC: String
}

struct FoodService {
    
    static func uploadFoodInfo(foodInfo: FoodInfo, completion: @escaping ((Error?) -> Void)) {
        
        ImageUploader.uploadFoodImage(image: foodInfo.foodImage) { imageUrl in
            
            let protein = foodInfo.amount.protein
            let calcium = foodInfo.amount.calcium
            let iron = foodInfo.amount.iron
            let vitaminA = foodInfo.amount.vitaminA
            let vitaminB = foodInfo.amount.vitaminB
            let vitaminC = foodInfo.amount.vitaminC
            let vitaminE = foodInfo.amount.vitaminE
            let vitaminD = foodInfo.amount.vitaminD
            
            let name = foodInfo.foodName
            let amount: [String: String] = ["protein": protein,
                                            "calcium": calcium,
                                            "iron": iron,
                                            "vitaminA": vitaminA,
                                            "vitaminB": vitaminB,
                                            "vitaminC": vitaminC,
                                            "vitaminE": vitaminE,
                                            "vitaminD": vitaminD]
            let category = foodInfo.foodCategory
            
            let data:[String: Any] = ["foodImageUrl": imageUrl,
                                      "foodName": name,
                                      "amount": amount,
                                      "foodCategory": category]
            
            COLLECTION_FOODS.document(name).setData(data, completion: completion)
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
