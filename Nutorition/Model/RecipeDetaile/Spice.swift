import UIKit

struct Spice {
    let spiceID: String
    let names: [String]
    let amounts: [String]
    
    init(data: [String: Any]) {
        self.spiceID = data["spiceID"] as? String ?? ""
        self.names = data["names"] as? [String] ?? [""]
        self.amounts = data["amounts"] as? [String] ?? [""]
    }
}
