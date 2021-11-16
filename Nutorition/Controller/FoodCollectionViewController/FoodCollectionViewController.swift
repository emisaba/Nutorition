import UIKit

class FoodCollectonViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    public let headerIdentifier = "headerIdentifier"
    public let identifier = "identifier"
    
    private lazy var addFoodButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 30
        button.backgroundColor = .systemTeal
        button.addTarget(self, action: #selector(didTapAddFoodButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var doneSelectButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 30
        button.backgroundColor = .systemTeal
        button.addTarget(self, action: #selector(didTapDoneButton), for: .touchUpInside)
        return button
    }()
    
    public var selectedFoodCategory = ""
    public var foods: [FoodItem] = [] {
        didSet { collectionView.reloadData() }
    }
    
    public var foodNames = [String]()
    public var proteins = [Double]()
    public var calciums = [Double]()
    public var irons = [Double]()
    public var vitaminaAs = [Double]()
    public var vitaminDs = [Double]()
    public var vitaminEs = [Double]()
    public var vitaminBs = [Double]()
    public var vitaminCs = [Double]()
    
    public var carbons = [FoodItem]()
    public var veges = [FoodItem]()
    public var fruits = [FoodItem]()
    public var dairies = [FoodItem]()
    public var meats = [FoodItem]()
    public var fishes = [FoodItem]()
    public var soys = [FoodItem]()
    
    public var amountData = [String: Double]()
    public var completion: (([String: Double]) -> Void)?
    
    public var userDefaults = UserDefaults()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        configureCollectionView()
        configureUI()
        
        fetchFoods()
    }
    
    // MARK: - API
    
    func fetchFoods() {
        FoodService.fetchFoodInfo { foods in
            self.foods = foods
        }
    }
    
    // MARK: - Actions
    
    @objc func didTapAddFoodButton() {
        let vc = SelectFoodViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapDoneButton() {
        completion?(amountData)
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    
    func configureCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(FoodCollectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: headerIdentifier)
        collectionView.register(FoodCollectionViewCell.self,
                                forCellWithReuseIdentifier: identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func configureUI() {
        
        view.addSubview(doneSelectButton)
        doneSelectButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,
                          paddingBottom: 30)
        doneSelectButton.setDimensions(height: 60, width: 150)
        doneSelectButton.centerX(inView: view)
        
        view.addSubview(addFoodButton)
        addFoodButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         right: view.rightAnchor,
                         paddingBottom: 30,
                         paddingRight: 30)
        addFoodButton.setDimensions(height: 60, width: 60)
    }
}
