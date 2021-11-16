import Foundation

enum RegisterViewCategoryType: CaseIterable {
    case foodImage
    case foodName
    case foodAmount
    case foodCategory
    
    var categoryText: String {
        switch self {
        case .foodImage:
            return "画像"
        case .foodName:
            return "名前"
        case .foodAmount:
            return "量"
        case .foodCategory:
            return "カテゴリ"
        }
    }
}
