import UIKit

class TopCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let foodImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "map")
        iv.layer.cornerRadius = 10
        return iv
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper
    
    func configureUI() {
        addSubview(foodImageView)
        foodImageView.fillSuperview()
    }
}
