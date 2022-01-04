import UIKit

protocol FoodListViewDelegate {
    func didSelect(ingredientDetaile: IngredientDetaile)
    func didDeselect(ingredientDetaile: IngredientDetaile)
}

class FoodListView: UIView {
    
    // MARK: - Properties
    
    public var delegate: FoodListViewDelegate?
    
    private let identifier = "identifier"
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.register(FoodListViewCell.self, forCellWithReuseIdentifier: identifier)
        cv.backgroundColor = .white
        cv.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return cv
    }()
    
    public var ingredientDetailes: [IngredientDetaile] = [] {
        didSet { collectionView.reloadData() }
    }
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(collectionView)
        collectionView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDataSource

extension FoodListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ingredientDetailes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! FoodListViewCell
        cell.viewModel = FoodListViewCellViewModel(ingredientDetaile: ingredientDetailes[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension FoodListView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? FoodListViewCell else { return }
        guard let ingredientDetaile = cell.viewModel?.ingredientDetaile else { return }
        
        cell.didSelect.toggle()
        
        if cell.didSelect {
            cell.didSelectUI()
            delegate?.didSelect(ingredientDetaile: ingredientDetaile)
        } else {
            cell.didDeselectUI()
            delegate?.didDeselect(ingredientDetaile: ingredientDetaile)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FoodListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 80)
    }
}
