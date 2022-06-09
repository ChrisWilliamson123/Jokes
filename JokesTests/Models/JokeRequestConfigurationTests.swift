import XCTest
@testable import Jokes

class JokeRequestConfigurationTests: XCTestCase {
    func testUrl_givenACountAndFalseExcludeExplicit_returnsExpectedURL() {
        let config = JokeRequestConfiguration(count: 5, excludeExplicit: false)
        
        let url = config.url
        
        XCTAssertEqual(url, URL(string: "http://api.icndb.com/jokes/random/5?exclude=[]&escape=javascript&")!)
    }
    
    func testUrl_givenACountAndTrueExcludeExplicit_returnsExpectedURL() {
        let config = JokeRequestConfiguration(count: 5, excludeExplicit: true)
        
        let url = config.url
        
        XCTAssertEqual(url, URL(string: "http://api.icndb.com/jokes/random/5?exclude=[explicit]&escape=javascript&")!)
    }
    
    func testUrl_givenACountAndTrueExcludeExplicitAndAMainCharacter_returnsExpectedURL() {
        let mainCharacter = MainCharacter(firstName: "James", lastName: "Bond")
        let config = JokeRequestConfiguration(count: 5, mainCharacter: mainCharacter, excludeExplicit: false)
        
        let url = config.url

        XCTAssertEqual(url, URL(string: "http://api.icndb.com/jokes/random/5?exclude=[explicit]&escape=javascript&firstName=James&lastName=Bond")!)
    }
}
