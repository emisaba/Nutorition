import UIKit

class TopViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var circleWidth = view.frame.width - 100
    private lazy var frameWidth = view.frame.width
    private lazy var frameHeight = view.frame.height
    
    private lazy var graphView = GraphView(frame: CGRect(x: 0, y: view.safeAreaInsets.top,
                                                         width: view.frame.width,
                                                         height: view.frame.height / 2 - 40), isTop: true)
    
    private lazy var effectButton = UIButton.createImageButton(image: #imageLiteral(resourceName: "fruit"), cornerRadius: 0,
                                                          isUserInteraction: true, target: self,
                                                          selector: #selector(didTapEffectButton))
    
    private let categoryView = CategoryView()
    private let foodListView = FoodListView()
    private lazy var bottomButton = createBottomButton()
    
    private let userDefaults = UserDefaults()
    
    private var selectedIngredients: [IngredientDetaile] = []
    public var ingredientDetailes: [IngredientDetaile] = []
    
    private var amountDataSum = AmountDataSum(protein: 0, calcium: 0, iron: 0, vitaminA: 0, vitaminB: 0, vitaminC: 0, vitaminD: 0, vitaminE: 0)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureUI()
        fetchIngredient()
    }
    
    // MARK: - API
    
    func fetchIngredient() {
        
        IngredientService.fetchIngredients { ingredientDetailes in
            
            var ingredientDetailes = ingredientDetailes
            ingredientDetailes.sort { $0.protein > $1.protein }
            
            self.ingredientDetailes = ingredientDetailes
            self.foodListView.ingredientDetailes = ingredientDetailes
        }
    }
    
    // MARK: - Action
    
    @objc func didTapEffectButton() {
        categoryView.isBeauty.toggle()
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
        
        view.addSubview(effectButton)
        effectButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                            right: view.rightAnchor,
                            paddingTop: 10, paddingRight: 30)
        
        view.addSubview(categoryView)
        categoryView.delegate = self
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
    
    func stringToDouble(ingredientDetaile: IngredientDetaile, didSelect: Bool) -> AmountDataSum? {
        guard let protein = Double(ingredientDetaile.protein) else { return nil }
        guard let calcium = Double(ingredientDetaile.calcium) else { return nil }
        guard let iron = Double(ingredientDetaile.iron) else { return nil }
        guard let vitaminA = Double(ingredientDetaile.vitaminA) else { return nil }
        guard let vitaminB = Double(ingredientDetaile.vitaminB) else { return nil }
        guard let vitaminC = Double(ingredientDetaile.vitaminC) else { return nil }
        guard let vitaminD = Double(ingredientDetaile.vitaminD) else { return nil }
        guard let vitaminE = Double(ingredientDetaile.vitaminE) else { return nil }
        
        let properProtein = didSelect ? protein : -protein
        let properCalcium = didSelect ? calcium : -calcium
        let properIron = didSelect ? iron : -iron
        let properVitaminA = didSelect ? vitaminA : -vitaminA
        let properVitaminB = didSelect ? vitaminB : -vitaminB
        let properVitaminC = didSelect ? vitaminC : -vitaminC
        let properVitaminD = didSelect ? vitaminD : -vitaminD
        let properVitaminE = didSelect ? vitaminE : -vitaminE
        
        let amountData = AmountDataSum(protein: properProtein,
                                       calcium: properCalcium,
                                       iron: properIron,
                                       vitaminA: properVitaminA,
                                       vitaminB: properVitaminB,
                                       vitaminC: properVitaminC,
                                       vitaminD: properVitaminD,
                                       vitaminE: properVitaminE)
        
        return amountData
    }
    
    func amountDataSum(amountData: AmountDataSum) {
        
        amountDataSum.protein += amountData.protein
        amountDataSum.calcium += amountData.calcium
        amountDataSum.iron += amountData.iron
        amountDataSum.vitaminA += amountData.vitaminA
        amountDataSum.vitaminB += amountData.vitaminB
        amountDataSum.vitaminC += amountData.vitaminC
        amountDataSum.vitaminD += amountData.vitaminD
        amountDataSum.vitaminE += amountData.vitaminE
        
        graphView.amountData = amountDataSum
    }
}

// MARK: - FoodListViewDelegate

extension TopViewController: FoodListViewDelegate {
    func didSelect(ingredientDetaile: IngredientDetaile) {
        guard let amountData = stringToDouble(ingredientDetaile: ingredientDetaile, didSelect: true) else { return }
        amountDataSum(amountData: amountData)
        
        selectedIngredients.append(ingredientDetaile)
    }
    
    func didDeselect(ingredientDetaile: IngredientDetaile) {
        guard let amountData = stringToDouble(ingredientDetaile: ingredientDetaile, didSelect: false) else { return }
        amountDataSum(amountData: amountData)
        
        selectedIngredients.removeAll(where: { $0.ingredientID == ingredientDetaile.ingredientID } )
    }
}

// MARK: - CategoryViewDelegate

extension TopViewController: CategoryViewDelegate {
    
    func didSelectCategory(category: Category) {
        
        switch category {
        case .protein:
            ingredientDetailes.sort { $0.protein > $1.protein }
            
        case .calcium:
            ingredientDetailes.sort { $0.calcium > $1.calcium }
            
        case .iron:
            ingredientDetailes.sort { $0.iron > $1.iron }
            
        case .vitaminA:
            ingredientDetailes.sort { $0.vitaminA > $1.vitaminA }
            
        case .vitaminB:
            ingredientDetailes.sort { $0.vitaminB > $1.vitaminB }
            
        case .vitaminC:
            ingredientDetailes.sort { $0.vitaminC > $1.vitaminC }
            
        case .vitaminD:
            ingredientDetailes.sort { $0.vitaminD > $1.vitaminD }
            
        case .vitaminE:
            ingredientDetailes.sort { $0.vitaminE > $1.vitaminE }
        }
        
        foodListView.ingredientDetailes = ingredientDetailes
    }
}
