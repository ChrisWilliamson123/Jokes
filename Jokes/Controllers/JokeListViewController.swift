import UIKit

class JokeListViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private let fetcher = JokeFetcher()
    /// Single jokes array acts as the view model
    private var jokes: [Joke] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchJokes()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "jokeListTableViewCell")
        tableView.dataSource = self
        tableView.cellLayoutMarginsFollowReadableWidth = true
    }
    
    private func fetchJokes() {
        fetcher.fetchJokes(using: JokeRequestConfiguration(count: 10)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let newJokes): self.jokes.append(contentsOf: newJokes)
            case .failure: print("Failed getting jokes")
            }
        }
    }

    @IBAction func didTapLoadMoreButton(_ sender: Any) {
        fetchJokes()
    }
}

extension JokeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        jokes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jokeListTableViewCell") ?? UITableViewCell()
        let joke = jokes[indexPath.item]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = joke.joke
        return cell
    }
}
