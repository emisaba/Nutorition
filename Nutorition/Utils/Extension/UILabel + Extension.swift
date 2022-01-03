import UIKit

extension UILabel {
    
    static func createLabel(text: String, size: CGFloat) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: size)
        return label
    }
    
    static func createBoldLabel(text: String, size: CGFloat) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .boldSystemFont(ofSize: size)
        return label
    }
}
