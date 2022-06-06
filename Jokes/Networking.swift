import Foundation

class Networking {
    private let urlSession = URLSession.shared
    
    func fetchData<T: Decodable>(for url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        urlSession.fetchData(for: url, completion: completion)
    }
}
