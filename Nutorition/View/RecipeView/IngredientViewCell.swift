import UIKit

class IngredientViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let ingredientImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let nameLabel = UILabel()
    private let amountLabel = UILabel()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        addSubview(ingredientImageView)
        ingredientImageView.anchor(left: leftAnchor,
                                   paddingLeft: 10)
        ingredientImageView.centerY(inView: self)
        
        addSubview(nameLabel)
        nameLabel.anchor(left: ingredientImageView.rightAnchor,
                         paddingLeft: 10)
        nameLabel.centerY(inView: self)
        nameLabel.text = "name"
        
        addSubview(amountLabel)
        amountLabel.anchor(right: rightAnchor, paddingRight: 10)
        amountLabel.centerY(inView: self)
        amountLabel.text = "amount"
    }
}
