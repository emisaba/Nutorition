import UIKit

class RecipeListCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let imageView = UIImageView.createImageView(image: #imageLiteral(resourceName: "fruit"), cornerRadius: 5)
    private let titleLabel = UILabel.createBoldLabel(text: "タイトル", size: 24)
    
    private lazy var graphView = GraphView(frame: CGRect(x: 0, y: 80, width: frame.height - 80, height: frame.height - 80), isTop: false)
    
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let space: CGFloat = 20
        let imageWidth: CGFloat = 80
        
        addSubview(imageView)
        imageView.frame = CGRect(x: space, y: 0, width: imageWidth, height: imageWidth)
        
        addSubview(titleLabel)
        titleLabel.frame = CGRect(x: imageWidth + space * 2,
                                  y: 0,
                                  width: frame.width - (imageWidth + space),
                                  height: imageWidth)
        
        addSubview(graphView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
