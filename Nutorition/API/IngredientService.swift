import UIKit

struct IngredientService {
    
    static func uploadIngredient(ingredientInfos: [IngredientInfo], completion: @escaping(String) -> Void) {
        
        let ref = COLLECTION_INGREDIENTS.document()
        let ingredientID = ref.documentID
        
        var imageUrls: [String] = []
        var names: [String] = []
        var amounts: [String] = []
        var foodIds: [String] = []
        var data: [String: Any] = [:]
        
        var ingredientInfosCount = ingredientInfos.count
        
        ingredientInfos.forEach { ingredientInfo in
            
            FoodService.uploadFoodInfo(food: ingredientInfo.ingredient) { foodId in
                ImageUploader.uploadFoodImage(image: ingredientInfo.image) { imageUrl in
                    imageUrls.append(imageUrl)
                    names.append(ingredientInfo.name)
                    amounts.append(ingredientInfo.amount)
                    foodIds.append(foodId)
                    
                    data = ["ingredientID": ingredientID,
                            "foodIds": foodIds,
                            "imageUrls": imageUrls,
                            "names": names,
                            "amounts":amounts]
                    
                    ingredientInfosCount -= 1
                    
                    if ingredientInfosCount == 0 {
                        
                        print("###data:\(data)")
                        
                        ref.setData(data) { error in
                            if let error = error {
                                print("failed to upload ingredient info: \(error.localizedDescription)")
                                return
                            }
                            
                            completion(ingredientID)
                        }
                    }
                }
            }
        }
    }
}
