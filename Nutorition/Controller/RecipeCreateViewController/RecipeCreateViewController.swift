import UIKit

class RecipeCreateViewController: UIViewController {
    
    // MARK: - Properties
    
    public let recipeCreateView = RecipeCreateView()
    private lazy var doneButton = UIButton.createTextButton(text: "完了",
                                                            cornerRadius: 0,
                                                            isUserInteraction: true,
                                                            target: self,
                                                            selector: #selector(didTapDoneButton))
    public var updateCell: RecipeCreateViewCell?
    private var mainImageButton: UIButton?
    private var mainTitle: String = ""
    
    private var ingredientInfo: IngredientInfo?
    private var ingredientInfos: [IngredientInfo] = []
    
    private var spiceInfo: SpiceInfo?
    private var spiceInfos: [SpiceInfo] = []
    
    private var stepInfo: StepInfo?
    private var stepInfos: [StepInfo] = []
    
    public var selectedFoodInfo: Food?
    public var foodInfos: [Food] = []
    
    public lazy var graphView = GraphView(frame: CGRect(x: 0,
                                                        y: view.frame.height - view.frame.width,
                                                        width: view.frame.width,
                                                        height: view.frame.width), isTop: false)
    
    public var foodSum = AmountDataSum(protain: 0.0,
                                       calcium: 0.0,
                                       iron: 0.0,
                                       vitamina: 0.0,
                                       vitamind: 0.0,
                                       vitamine: 0.0,
                                       vitaminb: 0.0,
                                       vitaminc: 0.0)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegate()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - API
    
    func uploadRecipe() {
        
        guard let mainImage = mainImageButton?.image(for: .normal) else { return }
        let title = mainTitle
        let ingredientInfo = ingredientInfos
        let spiceInfo = spiceInfos
        let stepInfo = stepInfos
        let foodInfos = foodInfos
        
        let recipeInfo = RecipeInfo(mainImage: mainImage,
                                    title: title,
                                    ingredientInfos: ingredientInfo,
                                    spiceInfos: spiceInfo,
                                    stepInfos: stepInfo,
                                    foodInfos: foodInfos,
                                    foodSum: foodSum)
        
        RecipeService.uploadRecipe(recipeInfo: recipeInfo) { error in
            if let error = error {
                print("failed to upload recipe: \(error.localizedDescription)")
                return
            }
           
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - Action
    
    @objc func didTapDoneButton() {
        uploadRecipe()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(doneButton)
        doneButton.backgroundColor = .systemBlue
        doneButton.anchor(left: view.leftAnchor,
                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
                          right: view.rightAnchor,
                          height: 70)
        
        view.addSubview(recipeCreateView)
        recipeCreateView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                left: view.leftAnchor,
                                bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                right: view.rightAnchor, paddingBottom: 90)
    }
    
    func setDelegate() {
        recipeCreateView.delegate = self
        recipeCreateView.recipeCreateViewHeader.delegate = self
    }
    
    func addNewRow(updateCell: RecipeCreateViewCell) {
        guard let recipeDetaileType = updateCell.viewModel?.recipeDetaileType else { return }
        
        switch recipeDetaileType {
        case .ingredient:
            guard let image = updateCell.ingredientImate() else { return }
            guard let name = selectedFoodInfo?.food_name else { return }
            guard let food = selectedFoodInfo else { return }
            let amount = updateCell.ingredientAmountText()
            
            calculateNutrition(food: food, amount: amount)
            
            ingredientInfo = IngredientInfo(image: image, name: name, amount: amount, ingredient: food)
            guard let ingredientInfo = ingredientInfo else { return }
            
            ingredientInfos.forEach { if $0.name == name || $0.amount == amount  { return } }
            ingredientInfos.append(ingredientInfo)
            
        case .spice:
            let name = updateCell.nameTextFieldText()
            let amount = updateCell.spiceAmountText()
            if amount == "" { return }
            
            spiceInfo = SpiceInfo(name: name, amount: amount)
            guard let spiceInfo = spiceInfo else { return }
            
            spiceInfos.forEach { if $0.name == name || $0.amount == amount  { return } }
            spiceInfos.append(spiceInfo)
            
        case .step:
            let number = updateCell.stepNumber()
            let description = updateCell.descriptionTextViewText()
            
            stepInfo = StepInfo(number: number, description: description)
            guard let stepInfo = stepInfo else { return }
            
            stepInfos.append(stepInfo)
        }
    }
}

// MARK: - UIImagePickerControllerDelegate

extension RecipeCreateViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

        if let indexPath = updateCell?.viewModel?.indexPath {
            guard let cell = recipeCreateView.tableView.cellForRow(at: indexPath) as? RecipeCreateViewCell else { return }
            cell.setIngredientImage(image: image)
            
        } else if let updateMainImageButton = mainImageButton {
            updateMainImageButton.setImage(image, for: .normal)
        }

        dismiss(animated: true, completion: nil)
    }
}

// MARK: - RecipeCreateViewHeaderDelegate

extension RecipeCreateViewController: RecipeCreateViewHeaderDelegate {
    func didTapMainImageButton(imageButton: UIButton) {
        mainImageButton = imageButton
        
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        
        present(picker, animated: true, completion: nil)
    }
    
    func editTitleText(title: String) {
        self.mainTitle = title
    }
}
