import UIKit

class CategoryView: UIView {
    
    // MARK: - Properties
    
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
    
    private let categoryTitles: [String] = ["タンパク質",
                                            "カルシウム",
                                            "鉄",
                                            "ビタミンA",
                                            "ビタミンB",
                                            "ビタミンC",
                                            "ビタミンD",
                                            "ビタミンE"]
    
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
        return categoryTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! TopCategoryViewCell
        cell.categoryTitle = categoryTitles[indexPath.row]
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension CategoryView: UICollectionViewDelegate {
    
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
