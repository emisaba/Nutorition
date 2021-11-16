import UIKit

protocol FoodInfoViewCellDelegate {
    func picker()
    func inputFoodInfo(cell: FoodInfoViewCell)
}

class FoodInfoViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    public var delegate: FoodInfoViewCellDelegate?
    
    public var viewModel: FoodViewModel? {
        didSet { configureUI() }
    }
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        return label
    }()
    
    lazy var foodImageButton: UIButton = {
        let button = UIButton()
        button.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemYellow
        button.addTarget(self, action: #selector(didTapFoodImageButton), for: .touchUpInside)
        return button
    }()
    
    lazy var foodNameField: UITextField = {
        let tv = UITextField()
        tv.textAlignment = .right
        tv.font = .boldSystemFont(ofSize: 16)
        tv.inputAccessoryView = toolBar
        tv.addTarget(self, action: #selector(didChangeText), for: .editingDidEnd)
        return tv
    }()
    
    lazy var amountTextField: UITextField = {
        let tv = UITextField()
        tv.placeholder = "100"
        tv.textAlignment = .center
        tv.layer.cornerRadius = 5
        tv.layer.borderWidth = 2
        tv.layer.borderColor = UIColor.lightGray.cgColor
        tv.inputAccessoryView = toolBar
        tv.addTarget(self, action: #selector(didChangeText), for: .editingDidEnd)
        return tv
    }()
    
    private lazy var toolBar: UIToolbar = {
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: UIBarButtonItem.Style.done,
                                         target: self,
                                         action: #selector(didTapDone))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace ,
                                     target: nil, action: nil)
        
        let toolBar = UIToolbar()
        toolBar.setItems([spacer, doneButton], animated: true)
        toolBar.sizeToFit()
        toolBar.isUserInteractionEnabled = true
        return toolBar
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.text = "g"
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()

    lazy var dropDownMenuView: DropDownMenuView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let view = DropDownMenuView(frame: .zero, collectionViewLayout: layout)
        view.layer.cornerRadius = 5
        return view
    }()
    
    private var toggleDropMenu = false
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        didTapArrowButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Action
    
    @objc func didTapDone() {
        self.endEditing(true)
    }
    
    @objc func didTapFoodImageButton() {
        delegate?.picker()
    }
    
    @objc func didChangeText() {
        self.endEditing(true)
        delegate?.inputFoodInfo(cell: self)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        guard let viewModel = viewModel else { return }
        
        questionLabel.text = viewModel.questionLabelText
        addSubview(questionLabel)
        questionLabel.anchor(left: leftAnchor, paddingLeft: 25)
        questionLabel.setDimensions(height: 100, width: 100)
        
        foodImageButton.isHidden = viewModel.foodImageViewIshidden
        addSubview(foodImageButton)
        foodImageButton.anchor(right: rightAnchor, paddingRight: 18)
        foodImageButton.setDimensions(height: 75, width: 75)
        foodImageButton.centerY(inView: self)
        
        foodNameField.text = viewModel.foodName
        foodNameField.isHidden = viewModel.foodNameFieldIshidden
        contentView.addSubview(foodNameField)
        foodNameField.anchor(top: topAnchor,
                             left: questionLabel.rightAnchor,
                             bottom: bottomAnchor,
                             right: rightAnchor,
                             paddingRight: 18)
        
        let amountStackView = UIStackView(arrangedSubviews: [amountTextField, amountLabel])
        amountStackView.spacing = 10
        amountStackView.isHidden = viewModel.amountStackViewIsHidden
        
        contentView.addSubview(amountStackView)
        amountStackView.anchor(right: rightAnchor, paddingRight: 18)
        amountStackView.setDimensions(height: 50, width: 120)
        amountStackView.centerY(inView: self)
        
        dropDownMenuView.isHidden = viewModel.dropDownMenuViewIsHidden
        contentView.addSubview(dropDownMenuView)
        dropDownMenuView.frame = CGRect(x: frame.width - 158, y: 20, width: 140, height: 60)
    }
    
    func didTapArrowButton() {
        NotificationCenter.default.addObserver(forName: Notification.Name("didTapArrowButton"), object: nil, queue: .main) { _ in
            
            self.toggleDropMenu.toggle()
            
            UIView.animate(withDuration: 0.25) {
                self.dropDownMenuView.frame.size.height = self.toggleDropMenu ? 420 : 60
            }
        }
    }
}
