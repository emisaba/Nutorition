import UIKit

extension UIImageView {
    
    static func createImageView(image: UIImage, cornerRadius: CGFloat) -> UIImageView {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = cornerRadius
        iv.image = image
        return iv
    }
}
