import UIKit

enum Category {
    case protein
    case calcium
    case iron
    case vitaminA
    case vitaminB
    case vitaminC
    case vitaminD
    case vitaminE
    
    var title: String {
        
        switch self {
        case .protein:
            return "タンパク質"
        case .calcium:
            return "カルシウム"
        case .iron:
            return "鉄"
        case .vitaminA:
            return "ビタミンA"
        case .vitaminB:
            return "ビタミンB"
        case .vitaminC:
            return "ビタミンC"
        case .vitaminD:
            return "ビタミンD"
        case .vitaminE:
            return "ビタミンE"
        }
    }
}
