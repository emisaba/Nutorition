import UIKit

class SelectTableView: UITableView {
    
    // MARK: - Properties
    
    private let identifier = "identifier"
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        separatorInset = .zero
        delegate = self
        dataSource = self
        register(SelectTableViewCell.self, forCellReuseIdentifier: identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func createButton() -> UIButton{
        let button = UIButton()
        button.backgroundColor = .systemPink
        return button
    }
}

// MARK: - UITableViewDataSource

extension SelectTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! SelectTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

// MARK: - UITableViewDelegate

extension SelectTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        guard let selectTableViewCell = cell as? SelectTableViewCell else { return }
        
        
    }
}
