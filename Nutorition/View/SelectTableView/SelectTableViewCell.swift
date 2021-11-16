import UIKit

class SelectTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let foodImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.layer.cornerRadius = 5
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "dammy"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let countTextField: UITextField = {
        let tf = UITextField()
        tf.font = .boldSystemFont(ofSize: 20)
        tf.text = "\(1)"
        return tf
    }()
    
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
        
        addSubview(foodImageView)
        foodImageView.anchor(left: leftAnchor, paddingLeft: 18)
        foodImageView.setDimensions(height: 60, width: 60)
        foodImageView.centerY(inView: self)
        
        contentView.addSubview(countTextField)
        countTextField.anchor(right: rightAnchor, paddingRight: -8)
        countTextField.setDimensions(height: 50, width: 50)
        countTextField.centerY(inView: self)
        
        addSubview(titleLabel)
        titleLabel.anchor(left: foodImageView.rightAnchor, right: countTextField.leftAnchor, paddingLeft: 18, paddingRight: 18)
        titleLabel.centerY(inView: self)
    }
}
