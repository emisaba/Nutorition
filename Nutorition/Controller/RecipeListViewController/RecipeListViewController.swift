import UIKit

class RecipeListViewController: UIViewController {
    
    // MARK: - Properties
    
    private let topIngredientView = TopIngredientView()
    
    private let identifier = "identifier"
    private lazy var recipeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.register(RecipeListCell.self, forCellWithReuseIdentifier: identifier)
        cv.backgroundColor = .white
        return cv
    }()
    
    public var selectedIngredients: [IngredientDetaile] = []
    
    private var recipes: [Recipe] = []
    
    // MARK: - Lifecycle
    
    init(selectedIngredients: [IngredientDetaile]) {
        self.topIngredientView.ingredientDetailes = selectedIngredients
        self.selectedIngredients = selectedIngredients
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchRecipes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - API
    
    func fetchRecipes() {
        selectedIngredients.forEach { selectedIngredient in
            RecipeService.fetchRecipes(foodId: selectedIngredient.foodID) { recipes in
                self.recipes = recipes
                self.recipeCollectionView.reloadData()
            }
        }
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(topIngredientView)
        topIngredientView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                 left: view.leftAnchor,
                                 right: view.rightAnchor,
                                 paddingTop: 10,
                                 height: 70)
        topIngredientView.centerX(inView: view)
        
        view.addSubview(recipeCollectionView)
        recipeCollectionView.anchor(top: topIngredientView.bottomAnchor,
                                    left: view.leftAnchor,
                                    bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                    right: view.rightAnchor)
    }
}

// MARK: - UICollectionViewDataSource

extension RecipeListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! RecipeListCell
        cell.viewModel = RecipeListCellViewModel(recipe: recipes[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension RecipeListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = RecipeDetaileViewController(recipe: recipes[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension RecipeListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = view.frame.width
        let height: CGFloat = width + 90
        return CGSize(width: width, height: height)
    }
}
