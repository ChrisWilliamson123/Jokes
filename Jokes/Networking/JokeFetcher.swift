import Foundation

struct JokeFetcher {
    private let networking: Networking
    
    init(networking: Networking = Networking()) {
        self.networking = networking
    }
    
    func fetchJokes(using configuration: JokeRequestConfiguration, completion: @escaping (Result<[Joke], Error>) -> ()) {
        networking.fetchData(for: configuration.url) { (result: Result<MultipleJokeResponse, Error>) in
            switch result {
            case .success(let response): completion(.success(response.value))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
}
