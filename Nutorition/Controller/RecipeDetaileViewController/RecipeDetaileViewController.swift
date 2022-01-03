import UIKit
import SDWebImage

class RecipeDetaileViewController: UIViewController {
    
    // MARK: - Properties
    
    private let imageView = UIImageView.createImageView(image: #imageLiteral(resourceName: "map"), cornerRadius: 5)
    private let titleTextFeild = UITextField.createBoldTextField(text: "タイトル", size: 22, isUserInteraction: false)
    private let ingredientView = RecipeDetaileView()
    
    private let recipe: Recipe
    
    // MARK: - Lifecycle
    
    init(recipe: Recipe) {
        self.recipe = recipe
        self.imageView.sd_setImage(with: URL(string: recipe.mainImageUrl), completed: nil)
        self.titleTextFeild.text = recipe.title
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - API
    
    
    
    // MARK: - Helper
    
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(imageView)
        imageView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         left: view.leftAnchor,
                         right: view.rightAnchor,
                         paddingLeft: 10,
                         paddingBottom: 10,
                         height: 200)
        
        view.addSubview(titleTextFeild)
        titleTextFeild.anchor(top: imageView.bottomAnchor,
                              left: view.leftAnchor,
                              right: view.rightAnchor,
                              paddingTop: 10,
                              height: 20)
        
        view.addSubview(ingredientView)
        ingredientView.anchor(top: titleTextFeild.bottomAnchor,
                              left: view.leftAnchor,
                              bottom: view.safeAreaLayoutGuide.bottomAnchor,
                              right: view.rightAnchor,
                              paddingTop: 20)
    }
}
