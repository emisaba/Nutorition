import UIKit

protocol FoodCollectionHeaderViewDelegate {
    func didTapCategoryButton(cell: FoodCollectionHeaderView, sender: UIButton)
}

class FoodCollectionHeaderView: UICollectionReusableView {
    
    // MARK: - Properties
    
    public var delegate: FoodCollectionHeaderViewDelegate?
    
    public lazy var carbonButton = createButton(image: UIImage())
    public lazy var vegeButton = createButton(image: UIImage())
    public lazy var fruitButton = createButton(image: UIImage())
    public lazy var dairyButton = createButton(image: UIImage())
    public lazy var meatButton = createButton(image: UIImage())
    public lazy var fishButton = createButton(image: UIImage())
    public lazy var soyButton = createButton(image: UIImage())
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemYellow
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc func didTapCategoryButton(sender: UIButton) {
        delegate?.didTapCategoryButton(cell: self, sender: sender)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        
        let topStackView = UIStackView(arrangedSubviews: [carbonButton, vegeButton, fruitButton, dairyButton])
        topStackView.spacing = 30
        topStackView.distribution = .fillEqually
        
        addSubview(topStackView)
        topStackView.anchor(top: safeAreaLayoutGuide.topAnchor, paddingTop: 20)
        topStackView.setDimensions(height: 60, width: 330)
        topStackView.centerX(inView: self)
        
        let bottomStackView = UIStackView(arrangedSubviews: [meatButton, fishButton, soyButton])
        bottomStackView.spacing = 30
        bottomStackView.distribution = .fillEqually
        
        addSubview(bottomStackView)
        bottomStackView.anchor(top: topStackView.bottomAnchor, paddingTop: 20)
        bottomStackView.setDimensions(height: 60, width: 240)
        bottomStackView.centerX(inView: self)
    }
    
    func createButton(image: UIImage) -> UIButton {
        let button = UIButton()
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(didTapCategoryButton), for: .touchUpInside)
        return button
    }
}
