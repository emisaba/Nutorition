import UIKit

class TopViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var circleWidth = view.frame.width - 100
    private lazy var frameWidth = view.frame.width
    private lazy var frameHeight = view.frame.height
    
    private lazy var canvas = CanvasView(frame: self.view.frame)
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        return button
    }()
    
//    private let flowlayout: UICollectionViewFlowLayout = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        return layout
//    }()
    
    private let userDefaults = UserDefaults()
    
//    private lazy var morningIcon = createIcon()
//    private lazy var morningCollectionView = TopCollectionView(frame: .zero, collectionViewLayout: flowlayout)
//
//    private lazy var daytimeIcon = createIcon()
//    private lazy var daytimeCollectionView = TopCollectionView(frame: .zero, collectionViewLayout: flowlayout)
//
//    private lazy var nightIcon = createIcon()
//    private lazy var nightCollectionView = TopCollectionView(frame: .zero, collectionViewLayout: flowlayout)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Actions
    
    @objc func didTapRegisterButton() {
        let vc = FoodCollectonViewController(collectionViewLayout: UICollectionViewFlowLayout())
        vc.completion = { data in
            self.canvas.amountData = data
        }
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        
        self.view.addSubview(canvas)
        canvas.amountData = userDefaults.amountValue()
        
        view.addSubview(registerButton)
        registerButton.anchor(bottom: view.bottomAnchor,
                              right: view.rightAnchor,
                              paddingBottom: 30,
                              paddingRight: 30)
        registerButton.setDimensions(height: 50, width: 50)
//
//
//        morningIcon.setDimensions(height: 60, width: 60)
//        daytimeIcon.setDimensions(height: 60, width: 60)
//        nightIcon.setDimensions(height: 60, width: 60)
//
//        let timezoneStackView = UIStackView(arrangedSubviews: [morningIcon, daytimeIcon, nightIcon])
//        timezoneStackView.axis = .vertical
//        timezoneStackView.spacing = 40
//        timezoneStackView.distribution = .fillEqually
//
//        view.addSubview(timezoneStackView)
//        timezoneStackView.anchor(top: circleView.bottomAnchor,
//                                 left: view.leftAnchor,
//                                 paddingTop: 50,
//                                 paddingLeft: 30,
//                                 height: 260)
//
//        morningCollectionView.setDimensions(height: 80, width: view.frame.width - 110)
//        daytimeCollectionView.setDimensions(height: 80, width: view.frame.width - 110)
//        nightCollectionView.setDimensions(height: 80, width: view.frame.width - 110)
//
//        let foodStackView = UIStackView(arrangedSubviews: [morningCollectionView, daytimeCollectionView, nightCollectionView])
//        foodStackView.axis = .vertical
//        foodStackView.spacing = 10
//        foodStackView.distribution = .fillEqually
//
//        view.addSubview(foodStackView)
//        foodStackView.anchor(top: circleView.bottomAnchor,
//                             left: timezoneStackView.rightAnchor,
//                             paddingTop: 30,
//                             paddingLeft: 20,
//                             height: 300)
        
        
//        let morningStackView = UIStackView(arrangedSubviews: [morningIcon, morningCollectionView])
//        morningStackView.spacing = 10
        
        
//        let daytimeStackView = UIStackView(arrangedSubviews: [daytimeIcon, daytimeCollectionView])
//        let nightStackView = UIStackView(arrangedSubviews: [nightIcon, nightCollectionView])
//        let timezoneStackView = UIStackView(arrangedSubviews: [morningStackView, daytimeStackView, nightStackView])
//        timezoneStackView.axis = .vertical
//        timezoneStackView.spacing = 15
//
//        view.addSubview(timezoneStackView)
//        timezoneStackView.anchor(top: circleView.bottomAnchor,
//                                left: view.leftAnchor,
//                                bottom: view.safeAreaLayoutGuide.bottomAnchor,
//                                right: view.rightAnchor,
//                                paddingTop: 20)
        
    }
    
//    func createIcon() -> UIImageView {
//        let imageView = UIImageView()
//        imageView.backgroundColor = .systemYellow
//        imageView.layer.cornerRadius = 30
//        return imageView
//    }
}
