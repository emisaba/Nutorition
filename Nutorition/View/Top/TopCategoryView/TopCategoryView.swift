import UIKit

protocol CategoryViewDelegate {
    func didSelectCategory(category: Category)
}

class CategoryView: UIView {
    
    // MARK: - Properties
    
    public var delegate: CategoryViewDelegate?
    
    private let identifier = "identifier"
    
    private lazy var collectionVIew: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.register(TopCategoryViewCell.self, forCellWithReuseIdentifier: identifier)
        cv.backgroundColor = .systemPink
        cv.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    private let category: [Category] = [.protein,
                                        .calcium,
                                        .iron,
                                        .vitaminA,
                                        .vitaminB,
                                        .vitaminC,
                                        .vitaminD,
                                        .vitaminE]
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(collectionVIew)
        collectionVIew.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDataSource

extension CategoryView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! TopCategoryViewCell
        cell.categoryTitle = category[indexPath.row].title
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension CategoryView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectCategory(category: category[indexPath.row])
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CategoryView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
