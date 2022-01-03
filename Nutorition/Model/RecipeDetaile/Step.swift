import UIKit

struct Step {
    let stepID: String
    let number: String
    let description: String
    
    init(data: [String: Any]) {
        self.stepID = data["stepID"] as? String ?? ""
        self.number = data["number"] as? String ?? ""
        self.description = data["description"] as? String ?? ""
    }
}
