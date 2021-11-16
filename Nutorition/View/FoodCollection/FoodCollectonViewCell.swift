import UIKit
import SDWebImage

class FoodCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    public var viewModel: FoodListViewModel? {
        didSet { configureUI() }
    }
    
    private let foodimage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(foodimage)
        foodimage.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        guard let viewModel = viewModel else { return }
        foodimage.sd_setImage(with: viewModel.imageUrl)
    }
}
