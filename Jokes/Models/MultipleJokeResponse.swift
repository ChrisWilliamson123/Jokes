struct MultipleJokeResponse: Decodable {
    let type: String
    let value: [Joke]
}
