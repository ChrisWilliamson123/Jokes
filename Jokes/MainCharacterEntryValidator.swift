import Foundation
struct MainCharacterEntryValidator {
    
    func validateEntry(_ entry: String) -> Result<MainCharacter, ValidationError> {
        let words = entry.split(separator: " ").map({ String($0) })
        guard words.count == 2 else { return .failure(ValidationError.invalidWordCount)}
        for word in words {
            if !word.onlyContainsLetters { return .failure(ValidationError.wordContainsNonAlphaCharacter)}
        }
        return .success(MainCharacter(firstName: words[0], lastName: words[1]))
    }
    
    enum ValidationError: Error, CustomStringConvertible {
        /// When the number of words is less than or greater than two
        case invalidWordCount
        /// When a word contains non-alpha character
        case wordContainsNonAlphaCharacter
        
        var description: String {
            switch self {
            case .invalidWordCount: return "Error: Entry must contain two words: a first name and a last name"
            case .wordContainsNonAlphaCharacter: return "Error: Entry must only contain letters"
            }
        }
    }
}

private extension String {
    var onlyContainsLetters: Bool {
        return !isEmpty && range(of: "[^a-zA-Z]", options: .regularExpression) == nil
    }
}
