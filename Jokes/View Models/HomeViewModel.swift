import UIKit

struct JokeAlertConfiguration {
    let title: String
    let text: String
    
    static func build(from result: Result<[Joke], Error>) throws -> JokeAlertConfiguration {
        switch result {
        case .success(let jokes):
            if jokes.count == 0 { throw JokeAlertConfigurationError.noJokesAvailable }
            return build(from: .success(jokes[0]))
        case .failure(let error):
            return build(from: .failure(error) as Result<Joke, Error>)
        }
    }
    
    static func build(from result: Result<Joke, Error>) -> JokeAlertConfiguration {
        switch result {
        case .success(let joke): return JokeAlertConfiguration(title: "Random Joke", text: joke.joke)
        case .failure: return JokeAlertConfiguration(title: "Random Joke Error",
                                                     text: "Sorry, an error occured while fetching a random joke. Please try again later.")
        }
    }
    
    enum JokeAlertConfigurationError: Error {
        case noJokesAvailable
    }
}
