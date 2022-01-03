import UIKit

class TopViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var circleWidth = view.frame.width - 100
    private lazy var frameWidth = view.frame.width
    private lazy var frameHeight = view.frame.height
    
    private lazy var graphView = GraphView(frame: CGRect(x: 0, y: view.safeAreaInsets.top,
                                                         width: view.frame.width,
                                                         height: view.frame.height / 2 - 40), isTop: true)
    
    private let categoryView = CategoryView()
    private let foodListView = FoodListView()
    private lazy var bottomButton = createBottomButton()
    
    private let userDefaults = UserDefaults()
    
    private var selectedIngredients: [IngredientDetaile] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureUI()
        fetchIngredient()
    }
    
    // MARK: - API
    
    func fetchIngredient() {
        IngredientService.fetchIngredient { ingredientDetailes in
            self.foodListView.ingredientDetailes = ingredientDetailes
        }
    }
    
    // MARK: - Actions
    
    @objc func didTapLookButton() {
        let vc = RecipeListViewController(selectedIngredients: selectedIngredients)
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true, completion: nil)
    }
    
    @objc func didTapWriteButton() {
        let vc = RecipeCreateViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        
        self.view.addSubview(graphView)
        graphView.amountData = userDefaults.amountValue()
        
        view.addSubview(categoryView)
        categoryView.anchor(top: graphView.bottomAnchor,
                            left: view.leftAnchor,
                            right: view.rightAnchor,
                            height: 70)
        
        view.addSubview(bottomButton)
        bottomButton.anchor(left: view.leftAnchor,
                            bottom: view.safeAreaLayoutGuide.bottomAnchor,
                            right: view.rightAnchor,
                            height: 60)
        
        foodListView.delegate = self
        view.addSubview(foodListView)
        foodListView.anchor(top: categoryView.bottomAnchor,
                            left: view.leftAnchor,
                            bottom: bottomButton.topAnchor,
                            right: view.rightAnchor,
                            paddingBottom: 10)
    }
    
    func createBottomButton() -> UIView {
        
        let baseView = UIView()
        baseView.backgroundColor = .systemYellow
        
        let label = UILabel()
        label.text = "レシピを"
        label.textAlignment = .center
        
        baseView.addSubview(label)
        label.anchor(top: baseView.topAnchor,
                     left: baseView.leftAnchor,
                     right: baseView.rightAnchor,
                     paddingTop: -10,
                     height: 20)
        
        let lookButton = UIButton()
        lookButton.setTitle("みる", for: .normal)
        lookButton.setTitleColor(.systemGray, for: .normal)
        lookButton.addTarget(self, action: #selector(didTapLookButton), for: .touchUpInside)
        
        baseView.addSubview(lookButton)
        lookButton.anchor(top: baseView.topAnchor,
                          left: baseView.leftAnchor,
                          bottom: baseView.bottomAnchor,
                          width: view.frame.width / 2)
        
        let writeButton = UIButton()
        writeButton.setTitle("かく", for: .normal)
        writeButton.setTitleColor(.systemGray, for: .normal)
        writeButton.addTarget(self, action: #selector(didTapWriteButton), for: .touchUpInside)
        
        baseView.addSubview(writeButton)
        writeButton.anchor(top: baseView.topAnchor,
                           bottom: baseView.bottomAnchor,
                           right: baseView.rightAnchor,
                           width: view.frame.width / 2)
        
        return baseView
    }
    
    func stringToDouble(ingredientDetaile: IngredientDetaile, didSelect: Bool) -> [String: Double]? {
        guard let protein = Double(ingredientDetaile.protein) else { return nil }
        guard let calcium = Double(ingredientDetaile.calcium) else { return nil }
        guard let iron = Double(ingredientDetaile.iron) else { return nil }
        guard let vitaminA = Double(ingredientDetaile.vitaminA) else { return nil }
        guard let vitaminB = Double(ingredientDetaile.vitaminB) else { return nil }
        guard let vitaminC = Double(ingredientDetaile.vitaminC) else { return nil }
        guard let vitaminD = Double(ingredientDetaile.vitaminD) else { return nil }
        guard let vitaminE = Double(ingredientDetaile.vitaminE) else { return nil }
        
        let amountData: [String: Double] = ["protein": didSelect ? protein : -protein,
                                            "calcium": didSelect ? calcium : -calcium,
                                            "iron": didSelect ? iron : -iron,
                                            "vitaminA": didSelect ? vitaminA : -vitaminA,
                                            "vitaminB": didSelect ? vitaminB : -vitaminB,
                                            "vitaminC": didSelect ? vitaminC : -vitaminC,
                                            "vitaminD": didSelect ? vitaminD : -vitaminD,
                                            "vitaminE": didSelect ? vitaminE : -vitaminE]
        
        return amountData
    }
}

// MARK: - FoodListViewDelegate

extension TopViewController: FoodListViewDelegate {
    func didSelect(ingredientDetaile: IngredientDetaile) {
        guard let amountData = stringToDouble(ingredientDetaile: ingredientDetaile, didSelect: true) else { return }
        graphView.amountData = amountData
        
        selectedIngredients.append(ingredientDetaile)
    }
    
    func didDeselect(ingredientDetaile: IngredientDetaile) {
        guard let amountData = stringToDouble(ingredientDetaile: ingredientDetaile, didSelect: false) else { return }
        graphView.amountData = amountData
        
        selectedIngredients.removeAll(where: { $0.ingredientID == ingredientDetaile.ingredientID } )
    }
}
