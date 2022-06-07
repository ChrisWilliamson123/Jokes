import Foundation

struct JokeFetcher {
    private let networking: Networking
    
    init(networking: Networking = Networking()) {
        self.networking = networking
    }
    
    func fetchJokes(using configuration: JokeRequestConfiguration, completion: @escaping (Result<[Joke], Error>) -> ()) {
        print(configuration.url)
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
    private let excludeExplicit: Bool
    
    init(count: Int, mainCharacter: MainCharacter? = nil, excludeExplicit: Bool = true) {
        self.count = count
        self.mainCharacter = mainCharacter
        self.excludeExplicit = excludeExplicit
    }
    
    var url: URL {
        URL(string: "http://api.icndb.com/jokes/random/\(count)?exclude=[\(excludeExplicit ? "explicit" : "")]&escape=javascript&\(mainCharacterString)")!
    }

    private var mainCharacterString: String {
        guard let mainCharacter = mainCharacter else { return "" }
        return "firstName=\(mainCharacter.firstName)&lastName=\(mainCharacter.lastName)"
    }
    
}
