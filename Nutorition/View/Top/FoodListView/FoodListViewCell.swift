import UIKit

class FoodListViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = frame.height / 2
        iv.backgroundColor = .systemGray
        return iv
    }()
    
    public var didSelect = false
    
//    override var isSelected: Bool {
//        didSet {
//            imageView.layer.borderWidth = isSelected ? 3 : 0
//            imageView.layer.borderColor = isSelected ? UIColor.systemPink.cgColor : UIColor.clear.cgColor
//        }
//    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        imageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didSelectUI() {
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.systemPink.cgColor
    }
    
    func didDeselectUI() {
        imageView.layer.borderWidth = 0
        imageView.layer.borderColor = UIColor.clear.cgColor
    }
}
