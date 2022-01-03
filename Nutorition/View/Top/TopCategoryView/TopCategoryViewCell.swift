import UIKit

class TopCategoryViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    public var categoryTitle: String? {
        didSet { textLabel.text = categoryTitle }
    }
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = frame.height / 2
        label.backgroundColor = .systemBlue
        label.textAlignment = .center
        label.clipsToBounds = true
        return label
    }()
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textLabel)
        textLabel.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
}
