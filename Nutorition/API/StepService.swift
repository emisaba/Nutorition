import UIKit

struct StepService {
    
    static func uploadStep(stepInfos: [StepInfo], completion: @escaping(String) -> Void) {
        
        let ref = COLLECTION_STEPS.document()
        let stepID = ref.documentID
        
        var numbers: [String] = []
        var descriptions: [String] = []
        
        stepInfos.forEach { stepInfo in
            numbers.append(stepInfo.number)
            descriptions.append(stepInfo.description)
        }
        
        let data: [String: Any] = ["stepID": stepID,
                                   "numbers": numbers,
                                   "descriptions": descriptions]
        
        ref.setData(data) { error in
            if let error = error {
                print("failed to upload ingredient info: \(error.localizedDescription)")
                return
            }
            
            completion(stepID)
        }
    }
}
