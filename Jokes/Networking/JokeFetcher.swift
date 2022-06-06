import Foundation

struct JokeFetcher {
    private static let baseUrl: String = "http://api.icndb.com"

    private let networking: Networking
    
    init(networking: Networking = Networking()) {
        self.networking = networking
    }

    func fetchRandomJoke(completion: @escaping (Result<Joke, Error>) -> ()) {
        networking.fetchData(for: URL(string: "\(Self.baseUrl)/jokes/random?exclude=[explicit]")!) { (result: Result<SingleJokeResponse, Error>) in
            switch result {
            case .success(let response): completion(.success(response.value))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
    
    func fetchJokes(count: Int = 10, completion: @escaping (Result<[Joke], Error>) -> ()) {
        networking.fetchData(for: URL(string: "\(Self.baseUrl)/jokes/random/\(count)?exclude=[explicit]")!) { (result: Result<MultipleJokeResponse, Error>) in
            switch result {
            case .success(let response): completion(.success(response.value))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
}
