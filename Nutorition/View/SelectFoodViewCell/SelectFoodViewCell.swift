import UIKit

class SelectFoodViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    public let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        return label
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
        selectionStyle = .none
        
        addSubview(titleLabel)
        titleLabel.anchor(left: leftAnchor,
                          right: rightAnchor,
                          paddingLeft: 18,
                          paddingRight: 18)
        
        titleLabel.centerY(inView: self)
    }
}
