import UIKit

class RegisterFoodViewController: UITableViewController {
    
    // MARK: - Properties
    
    private let identifier = "identifier"
    private var food: Food
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("登録", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 30
        button.backgroundColor = .systemTeal
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        return button
    }()
    
    private var foodImage = UIImage()
    private var categoryString = ""
    
    // MARK: - Lifecycle
    
    init(food: Food) {
        self.food = food
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
    
    func uploadFoodInfo() {
//        let amount = FoodAmount(protein: food.protein,
//                                calcium: food.calcium,
//                                iron: food.iron,
//                                vitaminA: food.vitaminA,
//                                vitaminD: food.vitaminD,
//                                vitaminE: food.vitaminE,
//                                vitaminB: food.vitaminB,
//                                vitaminC: food.vitaminC)
//
//        let foodInfo = FoodInfo(foodImage: foodImage, foodName: food.food_name, amount: amount, foodCategory: categoryString)
//
//        FoodService.uploadFoodInfo(food: foodInfo) { error in
//            if let error = error {
//                print("ERROR:\(error.localizedDescription)")
//                return
//            }
//            self.navigationController?.popToRootViewController(animated: true)
//        }
    }
    
    // MARK: - Actions
    
    @objc func didTapRegisterButton() {
        uploadFoodInfo()
    }
    
    @objc func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.addSubview(registerButton)
        registerButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,
                              paddingBottom: 20)
        registerButton.setDimensions(height: 60, width: 120)
        registerButton.centerX(inView: view)
        
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FoodInfoViewCell.self, forCellReuseIdentifier: identifier)
        
        view.addSubview(backButton)
        backButton.anchor(left: view.leftAnchor,
                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
                          paddingLeft: 30,
                          paddingBottom: 30)
        backButton.setDimensions(height: 60, width: 60)
    }
    
    func calculateNutorition(amount: Double) {
        
        guard let protein = Double(food.protein) else { return }
        guard let calcium = Double(food.calcium) else { return }
        guard let iron = Double(food.iron) else { return }
        guard let vitaminA = Double(food.vitaminA) else { return }
        guard let vitaminD = Double(food.vitaminD) else { return }
        guard let vitaminE = Double(food.vitaminE) else { return }
        guard let vitaminB = Double(food.vitaminB) else { return }
        guard let vitaminC = Double(food.vitaminC) else { return }
        
        let updatedprotein = protein / 100.0 * amount
        let updatedCalcium = calcium / 100.0 * amount
        let updatedIron = iron / 100.0 * amount
        let updatedVitaminA = vitaminA / 100.0 * amount
        let updatedVitaminB = vitaminB / 100.0 * amount
        let updatedVitaminC = vitaminC / 100.0 * amount
        let updatedVitaminD = vitaminD / 100.0 * amount
        let updatedVitaminE = vitaminE / 100.0 * amount
        
        food.protein = String(updatedprotein)
        food.calcium = String(updatedCalcium)
        food.iron = String(updatedIron)
        food.vitaminA = String(updatedVitaminA)
        food.vitaminB = String(updatedVitaminB)
        food.vitaminC = String(updatedVitaminC)
        food.vitaminD = String(updatedVitaminD)
        food.vitaminE = String(updatedVitaminE)
    }
}

// MARK: - UITableViewDataSource

extension RegisterFoodViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RegisterViewCategoryType.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! FoodInfoViewCell
        cell.viewModel = FoodViewModel(food: food, categoryTypr: RegisterViewCategoryType.allCases[indexPath.row])
        cell.delegate = self
        cell.dropDownMenuView.dropdownDelegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let nomalCellHeight: CGFloat = 100
        let categoryCellHeight: CGFloat = view.frame.height - nomalCellHeight * 3
        return indexPath.row == 3 ? categoryCellHeight : nomalCellHeight
    }
}

// MARK: - SelectFoodViewControllerCellDelegate

extension RegisterFoodViewController: FoodInfoViewCellDelegate {
    
    func inputFoodInfo(cell: FoodInfoViewCell) {
        guard let foodName = cell.foodNameField.text else { return }
        food.food_name = foodName
        
        guard let amount = Double(cell.amountTextField.text ?? "") else { return }
        calculateNutorition(amount: amount)
    }
    
    func picker() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
}

// MARK: - UIImagePickerControllerDelegate

extension RegisterFoodViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else { return }
        foodImage = image
        
        guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? FoodInfoViewCell else { return }
        cell.foodImageButton.setImage(image, for: .normal)
        
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - DropDownMenuViewDelegate

extension RegisterFoodViewController: DropDownMenuViewDelegate {
    func selectCategory(foodType: FoodType) {
        self.categoryString = foodType.foodName
    }
}
