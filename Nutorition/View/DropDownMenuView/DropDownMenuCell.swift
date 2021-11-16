import UIKit

class DropDownMenuCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    public var viewModel: DropDownViewModel? {
        didSet { configureViewModel() }
    }
    
    private lazy var arrowButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "arrow"), for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(didTapArrowButton), for: .touchUpInside)
        return button
    }()
    
    private var iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "fruit")
        iv.backgroundColor = .systemGreen
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        iconImageView.setDimensions(height: 60, width: 90)
        
        let stackView = UIStackView(arrangedSubviews: [iconImageView, arrowButton])
        contentView.addSubview(stackView)
        stackView.fillSuperview()
    }
    
    func configureViewModel() {
        
        guard let viewModel = viewModel else { return }
        arrowButton.setImage(viewModel.arrowImage, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc func didTapArrowButton() {
        NotificationCenter.default.post(name: Notification.Name("didTapArrowButton"), object: nil)
    }
}
