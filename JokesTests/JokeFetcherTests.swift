//
//  JokesTests.swift
//  JokesTests
//
//  Created by Chris on 06/06/2022.
//

import XCTest
@testable import Jokes

class JokeFetcherTests: XCTestCase {
    
    private var networking: NetworkingMock!
    
    override func setUp() {
        super.setUp()
        
        networking = NetworkingMock()
    }

    func testFetchRandomJoke_givenNetworkFetchesValidData_completesWithJokeObject() {
        networking.nextResponse = .success(buildJokeResponse())
        
        let expectedJoke = Joke(id: 1, joke: "A really funny joke", categories: [])
        
        let fetcher = JokeFetcher(networking: networking)
        fetcher.fetchRandomJoke { result in
            switch result {
            case .success(let joke): XCTAssertEqual(joke, expectedJoke)
            case .failure: XCTFail("Expected fetch to succeed")
            }
        }
    }
    
    func testFetchRandomJoke_givenNetworkFails_completesWithError() {
        networking.nextResponse = .failure(NSError(domain: "", code: 500, userInfo: [ NSLocalizedDescriptionKey: "Server error"]))
        
        let fetcher = JokeFetcher(networking: networking)
        fetcher.fetchRandomJoke { result in
            switch result {
            case .success: XCTFail("Expected fetch to fail")
            case .failure(let error): XCTAssertEqual(error.localizedDescription, "Server error")
            }
        }
    }
    
    private func buildJokeResponse() -> SingleJokeResponse {
        SingleJokeResponse(type: "success", value: Joke(id: 1, joke: "A really funny joke", categories: []))
    }
}

final class NetworkingMock: Networking {
    var nextResponse: Result<Decodable, Error>?
    
    override func fetchData<T: Decodable>(for url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        guard let nextResponse = nextResponse else { return }
        switch nextResponse {
        case .success(let decodable):
            guard let correctlyTypedDecodable = decodable as? T else { return }
            completion(.success(correctlyTypedDecodable))
        case .failure(let error):
            completion(.failure(error))
        }

    }
}
