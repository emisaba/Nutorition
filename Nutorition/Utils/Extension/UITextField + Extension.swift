import UIKit

extension UITextField {
    
    static func createTextField(text: String?, placeholer: String?, size: CGFloat, isUserInteraction: Bool, target: Any?, action: Selector) -> UITextField {
        let tf = UITextField()
        tf.textAlignment = .center
        tf.text = text
        tf.placeholder = placeholer
        tf.font = .systemFont(ofSize: size)
        tf.isUserInteractionEnabled = isUserInteraction
        tf.addTarget(action, action: action, for: .editingChanged)
        return tf
    }
    
    static func createBoldTextField(text: String?, size: CGFloat, isUserInteraction: Bool) -> UITextField {
        let tf = UITextField()
        tf.textAlignment = .center
        tf.textAlignment = .center
        tf.font = .boldSystemFont(ofSize: size)
        tf.isUserInteractionEnabled = isUserInteraction
        
        if text == nil {
            tf.placeholder = "タイトルを入力してください"
        } else {
            tf.text = text
        }
        
        return tf
    }
}
