import UIKit
import SDWebImage

class FoodListViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    public var viewModel: FoodListViewCellViewModel? {
        didSet { configureViewModel() }
    }
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 30
        iv.backgroundColor = .systemGray
        iv.clipsToBounds = true
        return iv
    }()
    
    private let nameLabel = UILabel.createLabel(text: "", size: 16)
    private let amountLabel = UILabel.createLabel(text: "", size: 16)
    
    public var didSelect = false
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBlue
        
        addSubview(imageView)
        imageView.anchor(left: leftAnchor, paddingLeft: 10)
        imageView.setDimensions(height: 60, width: 60)
        imageView.centerY(inView: self)
        
        addSubview(nameLabel)
        nameLabel.numberOfLines = 0
        nameLabel.anchor(left: imageView.rightAnchor, paddingLeft: 10)
        nameLabel.centerY(inView: self)
        
        addSubview(amountLabel)
        amountLabel.textAlignment = .center
        amountLabel.anchor(right: rightAnchor, paddingRight: 10)
        amountLabel.centerY(inView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureViewModel() {
        guard let viewModel = viewModel else { return }
        
        imageView.sd_setImage(with: viewModel.imageUrl, completed: nil)
        nameLabel.text = viewModel.name
        amountLabel.text = viewModel.amontt
    }
    
    func didSelectUI() {
        layer.borderWidth = 3
        layer.borderColor = UIColor.systemPink.cgColor
    }
    
    func didDeselectUI() {
        layer.borderWidth = 0
        layer.borderColor = UIColor.clear.cgColor
    }
}

struct FoodListViewCellViewModel {
    let ingredientDetaile: IngredientDetaile
    
    var imageUrl: URL? {
        return URL(string: ingredientDetaile.imageUrl)
    }
    
    var name: String {
        return ingredientDetaile.name
    }
    
    var amontt: String {
        return "\(ingredientDetaile.amount) g"
    }
    
    init(ingredientDetaile: IngredientDetaile) {
        self.ingredientDetaile = ingredientDetaile
    }
}
