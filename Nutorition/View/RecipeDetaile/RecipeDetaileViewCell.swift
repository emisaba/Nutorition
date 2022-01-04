import UIKit
import SDWebImage

class RecipeDetaileViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    public var viewModel: RecipeDetaileViewModel? {
        didSet { configureUI() }
    }
    
    private let ingredientImageView = UIImageView.createImageView(image: #imageLiteral(resourceName: "fruit"), cornerRadius: 25)
    private let ingredientNameLabel = UITextField()
    private let ingredientAmountLabel = UITextField()
    
    private let spiceNameLabel = UITextField()
    private let spiceAmountLabel = UITextField()
    
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
    
    func configureUI() {
        guard let viewModel = viewModel else { return }
        
        addSubview(ingredientImageView)
        ingredientImageView.anchor(left: leftAnchor,
                                   paddingLeft: 10)
        ingredientImageView.setDimensions(height: 50, width: 50)
        ingredientImageView.centerY(inView: self)
        
        ingredientImageView.sd_setImage(with: viewModel.ingredientImageUrl, completed: nil)
        ingredientImageView.isHidden = viewModel.shouldHideIngredientImage
        
        addSubview(ingredientNameLabel)
        ingredientNameLabel.anchor(left: ingredientImageView.rightAnchor,
                         paddingLeft: 10)
        ingredientNameLabel.centerY(inView: self)
        
        ingredientNameLabel.text = viewModel.ingredientName
        ingredientNameLabel.isHidden = viewModel.shouldHideIngredientName
        
        addSubview(ingredientAmountLabel)
        ingredientAmountLabel.anchor(right: rightAnchor, paddingRight: 10)
        ingredientAmountLabel.centerY(inView: self)
        
        ingredientAmountLabel.text = viewModel.ingredientAmount
        ingredientAmountLabel.isHidden = viewModel.shouldHideIngredientAmount
        
        addSubview(spiceNameLabel)
        spiceNameLabel.anchor(left: leftAnchor,
                         paddingLeft: 10)
        spiceNameLabel.centerY(inView: self)
        
        spiceNameLabel.text = viewModel.spiceName
        spiceNameLabel.isHidden = viewModel.shouldHideSpiceName
        
        addSubview(spiceAmountLabel)
        spiceAmountLabel.anchor(right: rightAnchor, paddingRight: 10)
        spiceAmountLabel.centerY(inView: self)
        
        spiceAmountLabel.text = viewModel.spiceAmount
        spiceAmountLabel.isHidden = viewModel.shouldHideSpiceAmount
        
        addSubview(stepNumber)
        stepNumber.anchor(left: leftAnchor, paddingLeft: 10)
        stepNumber.centerY(inView: self)
        
        stepNumber.text = viewModel.stepNumber
        stepNumber.isHidden = viewModel.shouldHideStepNumber
        
        addSubview(descriptionTextView)
        descriptionTextView.anchor(top: topAnchor,
                                   left: stepNumber.rightAnchor,
                                   bottom: bottomAnchor,
                                   right: rightAnchor,
                                   paddingTop: 10,
                                   paddingLeft: 10,
                                   paddingBottom: 10,
                                   paddingRight: 10)
        
        descriptionTextView.text = viewModel.stepDescription
        descriptionTextView.isHidden = viewModel.shouldHideStepDescription
    }
}
