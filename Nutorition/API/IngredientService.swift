import UIKit

struct IngredientInfoToRecipe {
    let ingredientID: String
    let foodIds: [String]
}

struct IngredientService {
    
    static func uploadIngredient(ingredientInfos: [IngredientInfo], completion: @escaping(IngredientInfoToRecipe) -> Void) {
        
        let ref = COLLECTION_INGREDIENTS.document()
        let ingredientID = ref.documentID
        
        var imageUrls: [String] = []
        var names: [String] = []
        var amounts: [String] = []
        var foodIds: [String] = []
        var data: [String: Any] = [:]
        
        var ingredientInfosCount = ingredientInfos.count
        
        ingredientInfos.forEach { ingredientInfo in
            
            FoodService.uploadFoodInfo(food: ingredientInfo) { foodId in
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
                        
                        ref.setData(data) { error in
                            if let error = error {
                                print("failed to upload ingredient info: \(error.localizedDescription)")
                                return
                            }
                            
                            let ingredientInfoToRecipe = IngredientInfoToRecipe(ingredientID: ingredientID, foodIds: foodIds)
                            completion(ingredientInfoToRecipe)
                        }
                    }
                }
            }
        }
    }
    
    static func fetchIngredients(completion: @escaping([IngredientDetaile]) -> Void) {
        COLLECTION_INGREDIENTS.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            var foodIdCount = 0
            var ingredientCount = 0
            var ingredientDetailes: [IngredientDetaile] = []
            
            let ingredients = documents.map { Ingredient(data: $0.data()) }
            
            ingredients.forEach { ingredient in
                ingredient.foodIds.forEach { foodId in
                    COLLECTION_FOODS.document(foodId).getDocument { document, _ in
                        
                        guard let data = document?.data() else { return }
                        let nutrition = Nutrition(data: data)
                        
                        let ingredientDetaileData: [String: Any] = ["ingredientID": ingredient.ingredientID,
                                                                    "foodID": nutrition.foodID,
                                                                    "imageUrl": nutrition.imageUrl,
                                                                    "name": nutrition.foodName,
                                                                    "amount": nutrition.amount,
                                                                    "protein": nutrition.protein,
                                                                    "calcium": nutrition.calcium,
                                                                    "iron": nutrition.iron,
                                                                    "vitaminA": nutrition.vitaminA,
                                                                    "vitaminB": nutrition.vitaminB,
                                                                    "vitaminC": nutrition.vitaminC,
                                                                    "vitaminD": nutrition.vitaminD,
                                                                    "vitaminE": nutrition.vitaminE]
                        
                        let ingredientDetaile = IngredientDetaile(data: ingredientDetaileData)
                        ingredientDetailes.append(ingredientDetaile)
                        
                        foodIdCount += 1
                        
                        if ingredientCount == ingredients.count && foodIdCount == ingredient.foodIds.count {
                            completion(ingredientDetailes)
                        }
                    }
                }
                ingredientCount += 1
            }
        }
    }
    
    static func fetchIngredient(ingredientID: String, completion: @escaping(Ingredient) -> Void) {
        COLLECTION_INGREDIENTS.document(ingredientID).getDocument { snapshot, _ in
            guard let data = snapshot?.data() else { return }
            
            let ingredient = Ingredient(data: data)
            completion(ingredient)
        }
    }
}
