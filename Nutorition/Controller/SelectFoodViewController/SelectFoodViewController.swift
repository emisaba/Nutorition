import UIKit

class SelectFoodViewController: UIViewController {
    
    // MARK: - Properties
    
    private let identifier = "identifier"
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(SelectFoodViewCell.self, forCellReuseIdentifier: identifier)
        return tv
    }()
    
    private lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.backgroundImage = UIImage()
        sb.delegate = self
        return sb
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 30
        button.backgroundColor = .systemTeal
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        return button
    }()
    
    private var searchFoods = [Food]()
    
    public var completion: ((Food) -> Void)?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        configureUI()
    }
    
    // MARK: - json
    
    func callJson(searchItem: String) {
        
        guard let jsonURL = Bundle(for: type(of: self)).path(forResource: "food", ofType: "json") else { return }
        guard let jsonString = try? String(contentsOf: URL(fileURLWithPath: jsonURL), encoding: String.Encoding.utf8) else { return }
        
        var foods: FoodContainer?
        
        do {
            foods = try JSONDecoder().decode(FoodContainer.self, from: Data(jsonString.utf8))
        } catch {
            print("ERROR: \(error.localizedDescription)")
        }
        
        guard let result = foods else { return }

        result.foods.forEach { food in
            
            if food.food_name.contains(searchItem) {
                self.searchFoods.append(food)
            }
        }
        
        tableView.reloadData()
    }
    
    func configureUI() {
        
        view.backgroundColor = .white
        
        view.addSubview(searchBar)
        searchBar.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         left: view.leftAnchor,
                         right: view.rightAnchor,
                         height: 50)
        
        view.addSubview(tableView)
        tableView.anchor(top: searchBar.bottomAnchor,
                         left: view.leftAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         right: view.rightAnchor)
        
        view.addSubview(backButton)
        backButton.anchor(left: view.leftAnchor,
                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
                          paddingLeft: 30,
                          paddingBottom: 30)
        backButton.setDimensions(height: 60, width: 60)
    }
    
    // MARK: - Actions
    
    @objc func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UISearchBarDelegate

extension SelectFoodViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        guard let searchItem = searchBar.text else { return }
        callJson(searchItem: searchItem)
    }
}

// MARK: - UITableViewDataSource

extension SelectFoodViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchFoods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! SelectFoodViewCell
        cell.titleLabel.text = searchFoods[indexPath.row].food_name
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SelectFoodViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let food = searchFoods[indexPath.row]
        completion?(food)
        
        dismiss(animated: true, completion: nil)
    }
}
