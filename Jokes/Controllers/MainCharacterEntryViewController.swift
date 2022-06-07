import UIKit

class MainCharacterEntryViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchButton.isEnabled = false
        searchBar.delegate = self
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

        let validated = MainCharacterEntryValidator().validateEntry(text)
        print(validated)
    }
}

extension MainCharacterEntryViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchButton.isEnabled = searchText.count > 0
    }
}
