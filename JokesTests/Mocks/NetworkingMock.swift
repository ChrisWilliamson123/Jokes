import Foundation
@testable import Jokes

final class NetworkingMock: Networking {
    var nextResponse: Result<Decodable, Error>?
    
    override func fetchData<T: Decodable>(for url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        guard let nextResponse = nextResponse else { return }
        switch nextResponse {
        case .success(let decodable):
            guard let correctlyTypedDecodable = decodable as? T else { return }
            completion(.success(correctlyTypedDecodable))
        case .failure(let error):
            completion(.failure(error))
        }

    }
}
