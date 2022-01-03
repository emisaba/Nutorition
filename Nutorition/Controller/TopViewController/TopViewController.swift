import UIKit

class TopViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var circleWidth = view.frame.width - 100
    private lazy var frameWidth = view.frame.width
    private lazy var frameHeight = view.frame.height
    
    private lazy var canvas = GraphView(frame: CGRect(x: 0, y: view.safeAreaInsets.top,
                                                       width: view.frame.width,
                                                       height: view.frame.height / 2 - 40), isTop: true)
    
    private let categoryView = CategoryView()
    private let foodListView = FoodListView()
    private lazy var bottomButton = createBottomButton()
    
    private let userDefaults = UserDefaults()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureUI()
    }
    
    // MARK: - Actions
    
    @objc func didTapLookButton() {
        let vc = RecipeListViewController()
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
        
        self.view.addSubview(canvas)
        canvas.amountData = userDefaults.amountValue()
        
        view.addSubview(categoryView)
        categoryView.anchor(top: canvas.bottomAnchor,
                            left: view.leftAnchor,
                            right: view.rightAnchor,
                            height: 70)
        
        view.addSubview(bottomButton)
        bottomButton.anchor(left: view.leftAnchor,
                            bottom: view.safeAreaLayoutGuide.bottomAnchor,
                            right: view.rightAnchor,
                            height: 60)
        
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
}
