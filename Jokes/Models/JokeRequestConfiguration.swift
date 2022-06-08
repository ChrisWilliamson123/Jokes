import Foundation

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
