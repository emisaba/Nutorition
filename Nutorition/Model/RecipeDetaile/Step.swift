import UIKit

struct Step {
    let stepID: String
    let numbers: [String]
    let descriptions: [String]
    
    init(data: [String: Any]) {
        self.stepID = data["stepID"] as? String ?? ""
        self.numbers = data["numbers"] as? [String] ?? [""]
        self.descriptions = data["descriptions"] as? [String] ?? [""]
    }
}
