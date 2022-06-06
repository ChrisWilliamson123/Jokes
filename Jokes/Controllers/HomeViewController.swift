import UIKit

class HomeViewController: UIViewController {
    
    private let fetcher = JokeFetcher()
    private let viewModel = HomeViewModel()

    @IBAction func didTapRandomJokeButton(_ sender: Any) {
        fetcher.fetchRandomJoke { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                let alert = self.createAlert(configuration: HomeViewModel.JokeAlertConfiguration.build(from: result))
                self.present(alert, animated: true)
            }
        }
    }
    
    private func createAlert(configuration: HomeViewModel.JokeAlertConfiguration) -> UIAlertController {
        let alert = UIAlertController(title: configuration.title, message: configuration.text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            alert.dismiss(animated: true)
        }))
        return alert
    }
}

