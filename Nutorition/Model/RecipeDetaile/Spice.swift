import UIKit

struct Spice {
    let spiceID: String
    let name: String
    let amount: String
    
    init(data: [String: Any]) {
        self.spiceID = data["spiceID"] as? String ?? ""
        self.name = data["name"] as? String ?? ""
        self.amount = data["amount"] as? String ?? ""
    }
}
