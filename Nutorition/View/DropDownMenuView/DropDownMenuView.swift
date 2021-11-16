import UIKit

protocol DropDownMenuViewDelegate {
    func selectCategory(foodType: FoodType)
}

class DropDownMenuView: UICollectionView {
    
    // MARK: - Properties
    
    public var dropdownDelegate: DropDownMenuViewDelegate?
    private let identifier = "identifier"
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        backgroundColor = .white
        
        register(DropDownMenuCell.self, forCellWithReuseIdentifier: identifier)
        delegate = self
        dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDataSource

extension DropDownMenuView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FoodType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! DropDownMenuCell
        cell.viewModel = DropDownViewModel(foodType: FoodType.allCases[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension DropDownMenuView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dropdownDelegate?.selectCategory(foodType: FoodType.allCases[indexPath.row])
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension DropDownMenuView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
