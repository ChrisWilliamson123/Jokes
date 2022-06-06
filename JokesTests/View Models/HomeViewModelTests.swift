import XCTest
@testable import Jokes

class HomeViewModelTests: XCTestCase {
    func testJokeAlertConfigurationBuilder_givenSuccessResult_buildsCorrectConfiguration() {
        let result: Result<Joke, Error> = .success(Joke(id: 1, joke: "A joke", categories: []))
        let alertConfiguration = HomeViewModel.JokeAlertConfiguration.build(from: result)
        
        XCTAssertEqual(alertConfiguration.title, "Random Joke")
        XCTAssertEqual(alertConfiguration.text, "A joke")
    }
    
    func testJokeAlertConfigurationBuilder_givenFailureResult_buildsCorrectConfiguration() {
        let result: Result<Joke, Error> = .failure(NSError(domain: "", code: 500, userInfo: [:]))
        let alertConfiguration = HomeViewModel.JokeAlertConfiguration.build(from: result)
        
        XCTAssertEqual(alertConfiguration.title, "Random Joke Error")
        XCTAssertEqual(alertConfiguration.text, "Sorry, an error occured while fetching a random joke. Please try again later.")
    }
}

