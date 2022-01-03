import UIKit

protocol RecipeCreateViewHeaderDelegate {
    func didTapMainImageButton(imageButton: UIButton)
    func editTitleText(title: String)
}

class RecipeCreateViewHeader: UIView {
    
    // MARK: - Properties
    
    public var delegate: RecipeCreateViewHeaderDelegate?
    
    private let mainImageButton = UIButton.createTextButton(text: "＋ 画像をのせる", cornerRadius: 5,
                                                      isUserInteraction: true, target: self,
                                                      selector: #selector(didTapMainImageButton))
    
    private let titleTextFeild = UITextField.createBoldTextField(text: nil, size: 22, isUserInteraction: true)
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        titleTextFeild.addTarget(self, action: #selector(editTextFeild), for: .editingChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Action
    
    @objc func didTapMainImageButton() {
        delegate?.didTapMainImageButton(imageButton: mainImageButton)
    }
    
    @objc func editTextFeild(sender: UITextField) {
        guard let title = sender.text else { return }
        delegate?.editTitleText(title: title)
    }
    
    // MARK: - Helper
    
    func configureUI() {
        backgroundColor = .white
        
        addSubview(mainImageButton)
        mainImageButton.anchor(top: safeAreaLayoutGuide.topAnchor,
                               left: leftAnchor,
                               right: rightAnchor,
                               paddingLeft: 10,
                               paddingRight: 10,
                               height: 200)
        
        addSubview(titleTextFeild)
        titleTextFeild.anchor(top: mainImageButton.bottomAnchor,
                              left: leftAnchor,
                              right: rightAnchor,
                              paddingTop: 20,
                              height: 20)
    }
}
