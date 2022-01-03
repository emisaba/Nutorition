import UIKit

protocol RecipeCreateViewDelegate {
    func showIngredientImagePicker(updateCell: RecipeCreateViewCell)
    func showIngredientView(celliIndexPth: IndexPath)
    func autoSave(cell: RecipeCreateViewCell)
}

class RecipeCreateView: UIView {
    
    // MARK: - Properties
    
    public var delegate: RecipeCreateViewDelegate?
    
    public let identifier = "identifier"
    
    public lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.delegate = self
        tv.dataSource = self
        tv.register(RecipeCreateViewCell.self, forCellReuseIdentifier: identifier)
        tv.backgroundColor = .systemRed
        
        tv.tableHeaderView = recipeCreateViewHeader
        tv.tableFooterView = graphView
        return tv
    }()
    
    public lazy var defaultCellCount = [[""], [""], [""]]
    private var updateCell: RecipeCreateViewCell?
    
    public lazy var graphView = GraphView(frame: CGRect(x: 0,
                                                        y: frame.height - frame.width,
                                                        width: frame.width,
                                                        height: frame.width), isTop: false)
    
    public lazy var recipeCreateViewHeader = RecipeCreateViewHeader(frame: CGRect(x: 0, y: 0, width: frame.width, height: 270))
    
    private var firstRedponderSection = 0
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(tableView)
        tableView.frame = CGRect(x: 0, y: 20, width: frame.width, height: frame.height)
    }
    
    // MARK: - Action
    
    @objc func didTapAddButton(sender: UIButton) {
        
        defaultCellCount[sender.tag].append("")
        let section = sender.tag
        let row = defaultCellCount[section].count - 1
        let indexPath = IndexPath(row: row, section: section)
        tableView.insertRows(at: [indexPath], with: .bottom)
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

extension RecipeCreateView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return RecipeDetaileType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return recipeDetaileType(section: section).title
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let addButton = UIButton.createTextButton(text: "＋ 追加", cornerRadius: 0,
                                                  isUserInteraction: true, target: self,
                                                  selector: #selector(didTapAddButton))
        addButton.tag = section
        addButton.backgroundColor = .white
        return addButton
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return defaultCellCount[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! RecipeCreateViewCell
        cell.delegate = self
        
        let recipeDetaileType = recipeDetaileType(section: indexPath.section)
        cell.viewModel = RecipeCreateViewModel(recipeDetaileType: recipeDetaileType, indexPath: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = indexPath.section
        
        switch section {
        case 0, 1:
            return 70
        case 2:
            return 150
        default:
            return 70
        }
    }
}

// MARK: - UITableViewDelegate

extension RecipeCreateView: UITableViewDelegate {

}

// MARK: - UICollectionViewDelegateFlowLayout

extension RecipeCreateView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 50)
    }
}

// MARK: - RecipeCreateViewCellDelegate

extension RecipeCreateView: RecipeCreateViewCellDelegate {
    func autoSave(cell: RecipeCreateViewCell) {
        delegate?.autoSave(cell: cell)
    }
    
    func showIngredientView(celliIndexPth: IndexPath) {
        delegate?.showIngredientView(celliIndexPth: celliIndexPth)
    }

    func didTapIngredientImage(cell: RecipeCreateViewCell) {
        delegate?.showIngredientImagePicker(updateCell: cell)
    }
}

// MARK: - UIScrollViewDelegate

extension RecipeCreateView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        endEditing(true)
    }
}
