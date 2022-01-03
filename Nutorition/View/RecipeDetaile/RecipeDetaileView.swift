import UIKit

class RecipeDetaileView: UIView {
    
    // MARK: - Properties
    
    private let identifier = "identifier"
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(RecipeDetaileViewCell.self, forCellReuseIdentifier: identifier)
        tv.rowHeight = 70
        tv.backgroundColor = .systemRed
        return tv
    }()
    
    public var recipeDetaile: RecipeDetaile?
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(tableView)
        tableView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func recipeDetaileType(section: Int) -> RecipeDetaileType {
        
        switch section {
        case 0:
            return RecipeDetaileType.ingredient
        case 1:
            return RecipeDetaileType.spice
        case 2:
            return RecipeDetaileType.step
        default:
            return RecipeDetaileType.step
        }
    }
}

// MARK: - UITableViewDataSource

extension RecipeDetaileView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return RecipeDetaileType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return recipeDetaileType(section: section).title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let recipeDetaileType = recipeDetaileType(section: section)
        
        switch recipeDetaileType  {
        case .ingredient:
            return recipeDetaile?.ingredient?.count ?? 0
        case .spice:
            return recipeDetaile?.spice?.count ?? 0
        case .step:
            return recipeDetaile?.step?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! RecipeDetaileViewCell
        
        let recipeDetaileType = recipeDetaileType(section: indexPath.section)
        guard let recipeDetaile = recipeDetaile else { return cell }
        
        cell.viewModel = RecipeDetaileViewModel(recipeDetaile: recipeDetaile,
                                                             indexPath: indexPath,
                                                             recipeDetaileType: recipeDetaileType)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension RecipeDetaileView: UITableViewDelegate {
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension RecipeDetaileView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 50)
    }
}
