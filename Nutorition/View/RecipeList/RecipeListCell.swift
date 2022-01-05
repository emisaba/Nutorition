import UIKit
import SDWebImage

class RecipeListCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    public var viewModel: RecipeListCellViewModel? {
        didSet { configureViewModel() }
    }
    
    private let imageView = UIImageView.createImageView(image: #imageLiteral(resourceName: "fruit"), cornerRadius: 5)
    private let titleLabel = UILabel.createBoldLabel(text: "タイトル", size: 24)
    
    private lazy var graphView = GraphView(frame: CGRect(x: 0, y: 90, width: frame.height - 90, height: frame.height - 90), isTop: false)
    
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let space: CGFloat = 20
        let imageWidth: CGFloat = 80
        
        addSubview(imageView)
        imageView.frame = CGRect(x: space, y: 0, width: imageWidth, height: imageWidth)
        
        addSubview(titleLabel)
        titleLabel.frame = CGRect(x: imageWidth + space * 2,
                                  y: 0,
                                  width: frame.width - (imageWidth + space),
                                  height: imageWidth)
        
        addSubview(graphView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper
    
    func configureViewModel() {
        guard let viewModel = viewModel else { return }
        
        imageView.sd_setImage(with: viewModel.imageUrl, completed: nil)
        titleLabel.text = viewModel.title
        graphView.amountData = viewModel.amountData
    }
}

struct RecipeListCellViewModel {
    let recipe: Recipe
    
    var imageUrl: URL? {
        return URL(string: recipe.mainImageUrl)
    }
    
    var title: String {
        return recipe.title
    }
    
    var amountData: AmountDataSum {
        let protein = Double(recipe.foodSum["protein"] ?? 0)
        let calcium =  Double(recipe.foodSum["calcium"] ?? 0)
        let iron =  Double(recipe.foodSum["iron"] ?? 0)
        let vitaminA =  Double(recipe.foodSum["vitaminA"] ?? 0)
        let vitaminB =  Double(recipe.foodSum["vitaminB"] ?? 0)
        let vitaminC =  Double(recipe.foodSum["vitaminC"] ?? 0)
        let vitaminD =  Double(recipe.foodSum["vitaminD"] ?? 0)
        let vitaminE =  Double(recipe.foodSum["vitaminE"] ?? 0)
        
        return AmountDataSum(protein: protein, calcium: calcium,
                             iron: iron, vitaminA: vitaminA,
                             vitaminB: vitaminB, vitaminC: vitaminC,
                             vitaminD: vitaminD, vitaminE: vitaminE)
    }

    init(recipe: Recipe) {
        self.recipe = recipe
    }
}
