import Firebase

struct RecipeService {
    
    static func uploadRecipe(recipeInfo: RecipeInfo, completion: @escaping(Error?) -> Void) {
        let ref = COLLECTION_RECIPES.document()
        let recipeID = ref.documentID
        
        IngredientService.uploadIngredient(ingredientInfos: recipeInfo.ingredientInfos) { ingredientInfoToRecipe in
            SpiceService.uploadSpice(spiceInfos: recipeInfo.spiceInfos) { spiceID in
                StepService.uploadStep(stepInfos: recipeInfo.stepInfos) { StepInfo in
                    
                    ImageUploader.uploadFoodImage(image: recipeInfo.mainImage) { imageUrl in
                        
                        let foodSum: [String: Any] = ["protein": recipeInfo.foodSum.protein,
                                                      "calcium": recipeInfo.foodSum.calcium,
                                                      "iron": recipeInfo.foodSum.iron,
                                                      "vitaminA": recipeInfo.foodSum.vitaminA,
                                                      "vitaminB": recipeInfo.foodSum.vitaminB,
                                                      "vitaminC": recipeInfo.foodSum.vitaminC,
                                                      "vitaminD": recipeInfo.foodSum.vitaminD,
                                                      "vitaminE": recipeInfo.foodSum.vitaminE]
                        
                        let data: [String: Any] = ["mainImageUrl": imageUrl,
                                                   "title": recipeInfo.title,
                                                   "recipeID": recipeID,
                                                   "ingredientID": ingredientInfoToRecipe.ingredientID,
                                                   "foodIds": ingredientInfoToRecipe.foodIds,
                                                   "spiceID": spiceID,
                                                   "stepID": StepInfo,
                                                   "foodSum": foodSum]
                        
                        ref.setData(data, completion: completion)
                    }
                }
            }
        }
    }
    
    static func fetchRecipes(foodId: String, completion: @escaping([Recipe]) -> Void) {
        
        COLLECTION_RECIPES.whereField("foodIds", arrayContains: foodId).getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            let recipes = documents.map { Recipe(data: $0.data()) }
            print("###recipes:\(recipes.first?.foodIds)")
            completion(recipes)
        }
    }
}
