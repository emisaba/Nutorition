import UIKit

extension UITextView {
    
    static func createTextView(text: String, size: CGFloat, interraction: Bool) -> UITextView {
        let tv = UITextView()
        tv.isUserInteractionEnabled = interraction
        tv.font = .systemFont(ofSize: size)
        tv.text = text
        tv.textContainerInset = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 10)
        return tv
    }
}
