import UIKit

class HomeViewController: UIViewController {
    
    private let fetcher = JokeFetcher()

    @IBAction func didTapRandomJokeButton(_ sender: Any) {
        fetcher.fetchJokes(using: JokeRequestConfiguration(count: 1)) { [weak self] result in
            guard let self = self else { return }
            
            let singleJokeResult: Result<Joke, Error>
            switch result {
            case .success(let jokes): singleJokeResult = .success(jokes[0])
            case .failure(let error): singleJokeResult = .failure(error)
            }
            
            DispatchQueue.main.async {
                let alert = self.createAlert(configuration: JokeAlertConfiguration.build(from: singleJokeResult))
                self.present(alert, animated: true)
            }
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

