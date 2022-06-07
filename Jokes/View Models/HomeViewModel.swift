import UIKit

struct JokeAlertConfiguration {
    let title: String
    let text: String
    
    static func build(from result: Result<Joke, Error>) -> JokeAlertConfiguration {
        switch result {
        case .success(let joke): return JokeAlertConfiguration(title: "Random Joke", text: joke.joke)
        case .failure: return JokeAlertConfiguration(title: "Random Joke Error",
                                                     text: "Sorry, an error occured while fetching a random joke. Please try again later.")
        }
    }
}
