import UIKit
import SDWebImage

class TopIngredientViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    public var imageUrl: String? {
        didSet { imageView.sd_setImage(with: URL(string: imageUrl ?? ""), completed: nil) }
    }
    
    private let imageView = UIImageView.createImageView(image: #imageLiteral(resourceName: "fruit"), cornerRadius: 25)
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        imageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
