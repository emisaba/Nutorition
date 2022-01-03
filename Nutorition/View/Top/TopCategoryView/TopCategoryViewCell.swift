import UIKit

class TopCategoryViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "テキスト"
        return label
    }()
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = frame.height / 2
        
        addSubview(textLabel)
        textLabel.anchor(top: topAnchor,
                         left: leftAnchor,
                         bottom: bottomAnchor,
                         right: rightAnchor,
                         paddingTop: 10,
                         paddingLeft: 10,
                         paddingBottom: 10,
                         paddingRight: 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
}
