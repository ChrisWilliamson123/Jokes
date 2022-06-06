import Foundation

struct JokeFetcher {
    private static let baseUrl: String = "http://api.icndb.com"
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    func fetchRandomJoke(completion: @escaping (Result<Joke, Error>) -> ()) {
        urlSession.fetchData(for: URL(string: "\(Self.baseUrl)/jokes/random?exclude=[explicit]")!) { (result: Result<SingleJokeResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
