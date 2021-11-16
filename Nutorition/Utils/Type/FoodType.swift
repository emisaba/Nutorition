import Foundation

enum FoodType: CaseIterable {
    case carbon
    case vege
    case fruit
    case dairy
    case meat
    case fish
    case soy
    
    var foodName: String {
        switch self {
        case .carbon:
            return "carbon"
        case .vege:
            return "vege"
        case .fruit:
            return "fruit"
        case .dairy:
            return "dairy"
        case .meat:
            return "meat"
        case .fish:
            return "fish"
        case .soy:
            return "soy"
        }
    }
}
