import Firebase

struct RecipeService {
    
    static func uploadRecipe(recipeInfo: RecipeInfo, completion: @escaping(Error?) -> Void) {
        let ref = COLLECTION_RECIPES.document()
        let recipeID = ref.documentID
        
        IngredientService.uploadIngredient(ingredientInfos: recipeInfo.ingredientInfos) { ingredientID in
            SpiceService.uploadSpice(spiceInfos: recipeInfo.spiceInfos) { spiceID in
                StepService.uploadStep(stepInfos: recipeInfo.stepInfos) { StepInfo in
                    
                    ImageUploader.uploadFoodImage(image: recipeInfo.mainImage) { imageUrl in
                        
                        let foodSum: [String: Any] = ["protain": recipeInfo.foodSum.protain,
                                                      "calcium": recipeInfo.foodSum.calcium,
                                                      "iron": recipeInfo.foodSum.iron,
                                                      "vitamina": recipeInfo.foodSum.vitamina,
                                                      "vitaminb": recipeInfo.foodSum.vitaminb,
                                                      "vitaminc": recipeInfo.foodSum.vitaminc,
                                                      "vitamind": recipeInfo.foodSum.vitamind,
                                                      "vitamine": recipeInfo.foodSum.vitamine]
                        
                        let data: [String: Any] = ["mainImageUrl": imageUrl,
                                                   "title": recipeInfo.title,
                                                   "recipeID": recipeID,
                                                   "ingredientID": ingredientID,
                                                   "spiceID": spiceID,
                                                   "stepID": StepInfo,
                                                   "foodSum": foodSum]
                        
                        ref.setData(data, completion: completion)
                    }
                }
            }
        }
    }
}
