struct Joke: Decodable, Equatable {
    let id: Int
    let joke: String
    let categories: [String]
}
