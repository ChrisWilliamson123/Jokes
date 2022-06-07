import UIKit

class MainCharacterEntryViewController: UIViewController {

    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var entryErrorLabel: UILabel!
    
    private let fetcher = JokeFetcher()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchButton.isEnabled = false
        searchBar.delegate = self
        entryErrorLabel.isHidden = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func didTapSearchButton(_ sender: Any) {
        let text = searchBar.text
        guard let text = text else { return }

        let validatedResult = MainCharacterEntryValidator().validateEntry(text)
        
        switch validatedResult {
        case .success(let mainCharacter):
            entryErrorLabel.isHidden = true
            let requestConfig = JokeRequestConfiguration(count: 1, mainCharacter: mainCharacter)
            fetcher.fetchJokes(using: requestConfig) { [weak self] result in
                guard let self = self else { return }
                
                guard let alertConfig = try? JokeAlertConfiguration.build(from: result) else { return }
                        
                DispatchQueue.main.async {
                    let alert = self.createAlert(configuration: alertConfig)
                    self.present(alert, animated: true)
                }
            }
        case .failure(let error):
            entryErrorLabel.text = error.description
            entryErrorLabel.isHidden = false
        }
    }
    
    private func createAlert(configuration: JokeAlertConfiguration) -> UIAlertController {
        let alert = UIAlertController(title: configuration.title, message: configuration.text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            alert.dismiss(animated: true)
        }))
        return alert
    }
}

extension MainCharacterEntryViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchButton.isEnabled = searchText.count > 0
    }
}
