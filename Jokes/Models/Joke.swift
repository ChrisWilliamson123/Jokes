struct Joke: Decodable {
    let id: Int
    let joke: String
    let categories: [String]
}
