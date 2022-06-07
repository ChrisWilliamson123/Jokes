import Foundation

struct JokeFetcher {
    private static let baseUrl: String = "http://api.icndb.com"

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

struct JokeRequestConfiguration {
    private let count: Int
    private let mainCharacter: MainCharacter?
    
    init(count: Int, mainCharacter: MainCharacter? = nil) {
        self.count = count
        self.mainCharacter = mainCharacter
    }
    
    var url: URL {
        URL(string: "http://api.icndb.com/jokes/random/\(count)?exclude=[explicit]&\(mainCharacterString)")!
    }

    private var mainCharacterString: String {
        guard let mainCharacter = mainCharacter else { return "" }
        return "firstName=\(mainCharacter.firstName)&lastName=\(mainCharacter.lastName)"
    }
    
}
