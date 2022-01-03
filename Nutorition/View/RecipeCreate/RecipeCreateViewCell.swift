import UIKit
import SDWebImage

protocol RecipeCreateViewCellDelegate {
    func didTapIngredientImage(cell: RecipeCreateViewCell)
    func showIngredientView(celliIndexPth: IndexPath)
    func autoSave(cell: RecipeCreateViewCell)
}

class RecipeCreateViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    public var delegate: RecipeCreateViewCellDelegate?
    
    public var viewModel: RecipeCreateViewModel? {
        didSet { configureUI() }
    }
    
    private lazy var ingredientImage = UIButton.createImageButton(image: #imageLiteral(resourceName: "fruit"), cornerRadius: 5,
                                                             isUserInteraction: true, target: self,
                                                             selector: #selector(didTapIngredientImage))
    
    private lazy var ingredientNameButton = UIButton.createTextButton(text: "食材を選択",
                                                                      cornerRadius: 0,
                                                                      isUserInteraction: true,
                                                                      target: self, selector: #selector(didTapIngredientNameButton))
    
    private let ingredientAmountLabel = UITextField.createTextField(text: nil,
                                                          placeholer: "100",
                                                          size: 18,
                                                          isUserInteraction: true,
                                                          target: self,
                                                          action: #selector(inputInfo))
    
    private let ingredientGramLabel = UILabel.createLabel(text: "g", size: 18)
    
    private let spiceNameTextField = UITextField.createTextField(text: nil,
                                                            placeholer: "材料名",
                                                            size: 18,
                                                            isUserInteraction: true,
                                                            target: self,
                                                            action: #selector(inputInfo))
    
    private let spiceAmountLabel = UITextField.createTextField(text: nil,
                                                          placeholer: "100",
                                                          size: 18,
                                                          isUserInteraction: true,
                                                          target: self,
                                                          action: #selector(inputInfo))
    
    private let spiceGramLabel = UILabel.createLabel(text: "g", size: 18)
    
    private let stepNumberLabel  = UILabel.createLabel(text: "", size: 14)
    private let descriptionTextView = UITextView.createTextView(text: "", size: 18, interraction: true)
    private let descripeionPlaceholder = UILabel.createLabel(text: "説明を入力してください...", size: 18)
    private lazy var didFinishDescriptionButton = UIButton.createImageButton(image: #imageLiteral(resourceName: "fruit"),
                                                                        cornerRadius: 0,
                                                                        isUserInteraction: true,
                                                                        target: self,
                                                                        selector: #selector(didTapDidFinishButton))
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Action
    
    @objc func didTapIngredientImage() {
        delegate?.didTapIngredientImage(cell: self)
    }
    
    @objc func inputInfo() {
        
    }
    
    @objc func didTapIngredientNameButton() {
        guard let indexPath = viewModel?.indexPath else { return }
        delegate?.showIngredientView(celliIndexPth: indexPath)
    }
    
    @objc func didTapDidFinishButton() {
        endEditing(true)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        
        guard let viewModel = viewModel else { return }
    
        contentView.addSubview(ingredientImage)
        ingredientImage.anchor(left: leftAnchor,
                               paddingLeft: 10)
        ingredientImage.setDimensions(height: 50, width: 50)
        ingredientImage.centerY(inView: self)
        ingredientImage.isHidden = viewModel.isIngredientImageHidden
        
        addSubview(ingredientNameButton)
        ingredientNameButton.anchor(left: ingredientImage.rightAnchor,
                                    paddingLeft: 10)
        ingredientNameButton.centerY(inView: self)
        ingredientNameButton.isHidden = viewModel.isIngredientNameButtonIsHidden
        
        addSubview(ingredientGramLabel)
        ingredientGramLabel.anchor(right: rightAnchor, paddingRight: 10)
        ingredientGramLabel.centerY(inView: self)
        ingredientGramLabel.isHidden = viewModel.isIngredientGramLabelHidden
        
        addSubview(ingredientAmountLabel)
        ingredientAmountLabel.anchor(right: ingredientGramLabel.leftAnchor, paddingRight: 10)
        ingredientAmountLabel.centerY(inView: self)
        ingredientAmountLabel.delegate = self
        ingredientAmountLabel.isHidden = viewModel.isIngredientAmountLabelHidden
        
        addSubview(spiceNameTextField)
        spiceNameTextField.anchor(left: leftAnchor,
                             paddingLeft: 10)
        spiceNameTextField.centerY(inView: self)
        spiceNameTextField.delegate = self
        spiceNameTextField.isHidden = viewModel.isNameTextFieldHidden
        
        addSubview(spiceGramLabel)
        spiceGramLabel.anchor(right: rightAnchor, paddingRight: 10)
        spiceGramLabel.centerY(inView: self)
        spiceGramLabel.isHidden = viewModel.isSpiceGramLabelHidden
        
        addSubview(spiceAmountLabel)
        spiceAmountLabel.anchor(right: spiceGramLabel.leftAnchor, paddingRight: 10)
        spiceAmountLabel.centerY(inView: self)
        spiceAmountLabel.delegate = self
        spiceAmountLabel.isHidden = viewModel.isSpiceAmountLabelHidden
        
        addSubview(stepNumberLabel)
        stepNumberLabel.anchor(left: leftAnchor, paddingLeft: 10)
        stepNumberLabel.centerY(inView: self)
        stepNumberLabel.isHidden = viewModel.isStepNumberLabelHidden
        
        let stepNumber = viewModel.indexPath.row
        stepNumberLabel.text = "\(stepNumber)"
        
        descriptionTextView.delegate = self
        addSubview(descriptionTextView)
        descriptionTextView.anchor(top: topAnchor,
                                   left: stepNumberLabel.rightAnchor,
                                   bottom: bottomAnchor,
                                   right: rightAnchor,
                                   paddingTop: 10,
                                   paddingLeft: 10,
                                   paddingBottom: 10,
                                   paddingRight: 10)
        descriptionTextView.backgroundColor = .systemPink
        descriptionTextView.isHidden = viewModel.isDescriptionTextVieweHidden
        
        addSubview(descripeionPlaceholder)
        descripeionPlaceholder.anchor(top: descriptionTextView.topAnchor,
                                      left: descriptionTextView.leftAnchor,
                                      paddingTop: 10,
                                      paddingLeft: 10)
        descripeionPlaceholder.isHidden = viewModel.isDescripeionPlaceholderHidden
        
        addSubview(didFinishDescriptionButton)
        didFinishDescriptionButton.anchor(bottom: descriptionTextView.bottomAnchor,
                                          right: descriptionTextView.rightAnchor,
                                          paddingBottom: 10,
                                          paddingRight: 10)
        didFinishDescriptionButton.setDimensions(height: 30, width: 30)
        didFinishDescriptionButton.isHidden = viewModel.isDidFinishDescriptionButtonHidden
    }
    
    func setIngredientImage(image: UIImage) {
        ingredientImage.setImage(image, for: .normal)
    }
    
    func ingredientImate() -> UIImage? {
        guard let image = ingredientImage.image(for: .normal) else { return nil }
        return image
    }
    
    func ingredientAmountText() -> String {
        guard let amount = ingredientAmountLabel.text else { return "" }
        return amount
    }
    
    func nameTextFieldText() -> String {
        guard let name = spiceNameTextField.text else { return "" }
        return name
    }
    
    func spiceAmountText() -> String {
        guard let amount = spiceAmountLabel.text else { return "" }
        return amount
    }
    
    func stepNumber() -> String {
        guard let number = stepNumberLabel.text else { return "" }
        return number
    }
    
    func descriptionTextViewText() -> String {
        guard let description = descriptionTextView.text else { return "" }
        return description
    }
    
    func setIngredientName(name: String) {
        ingredientNameButton.setTitle(name, for: .normal)
        ingredientNameButton.setTitleColor(.black, for: .normal)
    }
}

// MARK: - UITextViewDelegate

extension RecipeCreateViewCell: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        let IsTextViewEmpty = textView.text.isEmpty
        descripeionPlaceholder.isHidden = IsTextViewEmpty ? false : true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        delegate?.autoSave(cell: self)
    }
}

// MARK: - UITextFieldDelegate

extension RecipeCreateViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.autoSave(cell: self)
    }
}
