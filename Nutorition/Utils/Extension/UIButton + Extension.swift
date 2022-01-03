import UIKit

extension UIButton {
    
    static func createImageButton(image: UIImage, cornerRadius: CGFloat, isUserInteraction: Bool, target: Any?, selector: Selector) -> UIButton {
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.layer.cornerRadius = cornerRadius
        button.clipsToBounds = true
        button.isUserInteractionEnabled = isUserInteraction
        button.addTarget(target, action: selector, for: .touchUpInside)
        return button
    }
    
    static func createTextButton(text: String, cornerRadius: CGFloat, isUserInteraction: Bool, target: Any?, selector: Selector) -> UIButton {
        let button = UIButton()
        button.setTitle(text, for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.layer.cornerRadius = cornerRadius
        button.clipsToBounds = true
        button.isUserInteractionEnabled = isUserInteraction
        button.addTarget(target, action: selector, for: .touchUpInside)
        return button
    }
}
