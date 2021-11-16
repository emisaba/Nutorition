import UIKit

extension UserDefaults {
    
    func setAmountValue(value: [String: Double]) {
        let key = DateFormatter.createDate().string(from: Date())
        setValue(value, forKey: key)
    }
    
    func amountValue() -> [String: Double] {
        let key = DateFormatter.createDate().string(from: Date())
        return value(forKey: key) as? [String: Double] ?? [:]
    }
}

extension DateFormatter {
    
    static func createDate() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter
    }
}
