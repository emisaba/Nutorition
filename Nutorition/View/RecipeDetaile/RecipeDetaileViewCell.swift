import UIKit
import SDWebImage

class RecipeDetaileViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    public var viewModel: RecipeDetaileViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            switch viewModel.recipeDetaileType {
            case .ingredient:
                configureIngredientUI()
            case .spice:
                configureSpiceUI()
            case .step:
                configureStepUI()
            }
        }
    }
    
    private let ingredientImageView = UIImageView.createImageView(image: #imageLiteral(resourceName: "fruit"), cornerRadius: 25)
    
    private let nameLabel = UITextField()
    private let amountLabel = UITextField()
    
    private let stepNumber  = UILabel.createLabel(text: "", size: 14)
    private let descriptionTextView = UITextView.createTextView(text: "", size: 18, interraction: false)
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureIngredientUI() {
        guard let viewModel = viewModel else { return }
        
        addSubview(ingredientImageView)
        ingredientImageView.anchor(left: leftAnchor,
                                   paddingLeft: 10)
        ingredientImageView.setDimensions(height: 50, width: 50)
        ingredientImageView.centerY(inView: self)
        
        ingredientImageView.sd_setImage(with: viewModel.ingredientImageUrl, completed: nil)
        
        addSubview(nameLabel)
        nameLabel.anchor(left: ingredientImageView.rightAnchor,
                         paddingLeft: 10)
        nameLabel.centerY(inView: self)
        
        nameLabel.text = viewModel.ingredientName
        
        addSubview(amountLabel)
        amountLabel.anchor(right: rightAnchor, paddingRight: 10)
        amountLabel.centerY(inView: self)
        
        amountLabel.text = viewModel.ingredientAmount
    }
    
    func configureSpiceUI() {
        guard let viewModel = viewModel else { return }
        
        addSubview(nameLabel)
        nameLabel.anchor(left: ingredientImageView.rightAnchor,
                         paddingLeft: 10)
        nameLabel.centerY(inView: self)
        
        nameLabel.text = viewModel.spiceName
        
        addSubview(amountLabel)
        amountLabel.anchor(right: rightAnchor, paddingRight: 10)
        amountLabel.centerY(inView: self)
        
        amountLabel.text = viewModel.spiceAmount
    }
    
    func configureStepUI() {
        guard let viewModel = viewModel else { return }
        
        addSubview(stepNumber)
        stepNumber.anchor(left: leftAnchor, paddingLeft: 10)
        stepNumber.centerY(inView: self)
        
        stepNumber.text = viewModel.stepNumber
        
        addSubview(descriptionTextView)
        descriptionTextView.anchor(top: topAnchor,
                                   left: stepNumber.rightAnchor,
                                   bottom: bottomAnchor,
                                   right: rightAnchor,
                                   paddingTop: 10,
                                   paddingLeft: 10,
                                   paddingBottom: 10,
                                   paddingRight: 10)
        
        stepNumber.text = viewModel.stepDescription
    }
}
