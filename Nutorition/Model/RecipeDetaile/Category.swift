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
    
    func title(iBeauty: Bool) -> String {
        
        switch self {
        case .protein:
            return iBeauty ? "ハリ・弾力" : "タンパク質"
        case .calcium:
            return iBeauty ? "潤い" : "カルシウム"
        case .iron:
            return iBeauty ? "血色" : "鉄"
        case .vitaminA:
            return iBeauty ? "シワ" : "ビタミンA"
        case .vitaminB:
            return iBeauty ? "ニキビ" : "ビタミンB"
        case .vitaminC:
            return iBeauty ? "ツヤ" : "ビタミンC"
        case .vitaminD:
            return iBeauty ? "たるみ" : "ビタミンD"
        case .vitaminE:
            return iBeauty ? "アンチエイジング" : "ビタミンE"
        }
    }
}
