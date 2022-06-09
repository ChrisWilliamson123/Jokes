import XCTest
@testable import Jokes

class JokeFetcherTests: XCTestCase {
    
    private var networking: NetworkingMock!
    
    override func setUp() {
        super.setUp()
        
        networking = NetworkingMock()
    }

    func testFetchJokes_givenNetworkFetchesValidData_completesWithJokesObject() {
        networking.nextResponse = .success(buildJokeResponse())
        
        let expectedJokes = [Joke(id: 1, joke: "A really funny joke", categories: [])]
        
        let fetcher = JokeFetcher(networking: networking)
        fetcher.fetchJokes(using: JokeRequestConfiguration(count: 1)) { result in
            switch result {
            case .success(let jokes): XCTAssertEqual(jokes, expectedJokes)
            case .failure: XCTFail("Expected fetch to succeed")
            }
        }
    }
    
    func testFetchJokes_givenNetworkFails_completesWithError() {
        networking.nextResponse = .failure(NSError(domain: "",
                                                   code: 500,
                                                   userInfo: [ NSLocalizedDescriptionKey: "Server error"]))
        
        let fetcher = JokeFetcher(networking: networking)
        fetcher.fetchJokes(using: JokeRequestConfiguration(count: 1)) { result in
            switch result {
            case .success: XCTFail("Expected fetch to fail")
            case .failure(let error): XCTAssertEqual(error.localizedDescription, "Server error")
            }
        }
    }
    
    private func buildJokeResponse() -> MultipleJokeResponse {
        MultipleJokeResponse(type: "success", value: [Joke(id: 1, joke: "A really funny joke", categories: [])])
    }
}
