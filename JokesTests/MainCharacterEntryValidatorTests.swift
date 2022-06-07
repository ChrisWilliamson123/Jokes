import XCTest
@testable import Jokes

class MainCharacterEntryValidatorTests: XCTestCase {
    
    private var validator: MainCharacterEntryValidator!
    
    override func setUp() {
        super.setUp()
        
        validator = MainCharacterEntryValidator()
    }

    func testValidateEntry_givenEmptyString_failsWithInvalidWordCountError() {
        let result = validator.validateEntry("")
        
        switch result {
        case .success:
            XCTFail("Expected result to fail")
        case .failure(let error):
            XCTAssertEqual(error, MainCharacterEntryValidator.ValidationError.invalidWordCount)
            XCTAssertEqual(error.description, "Error: Entry must contain two words: a first name and a last name")
        }
    }
    
    func testValidateEntry_givenSingleWordString_failsWithInvalidWordCountError() {
        let result = validator.validateEntry("John")
        
        switch result {
        case .success:
            XCTFail("Expected result to fail")
        case .failure(let error):
            XCTAssertEqual(error, MainCharacterEntryValidator.ValidationError.invalidWordCount)
            XCTAssertEqual(error.description, "Error: Entry must contain two words: a first name and a last name")
        }
    }

    func testValidateEntry_givenThreeWordString_failsWithInvalidWordCountError() {
        let result = validator.validateEntry("John Smith Junior")
        
        switch result {
        case .success:
            XCTFail("Expected result to fail")
        case .failure(let error):
            XCTAssertEqual(error, MainCharacterEntryValidator.ValidationError.invalidWordCount)
            XCTAssertEqual(error.description, "Error: Entry must contain two words: a first name and a last name")
        }
    }
    
    func testValidateEntry_givenWordContainingNonLetter_failsWithNonAlphaError() {
        let result = validator.validateEntry("John 5m1th")
        
        switch result {
        case .success:
            XCTFail("Expected result to fail")
        case .failure(let error):
            XCTAssertEqual(error, MainCharacterEntryValidator.ValidationError.wordContainsNonAlphaCharacter)
            XCTAssertEqual(error.description, "Error: Entry must only contain letters")
        }
    }
    
    func testValidateEntry_givenValidEntry_succeedsWithMainCharacterObject() {
        let result = validator.validateEntry("John Smith")
        
        switch result {
        case .success(let mainCharacter):
            XCTAssertEqual(mainCharacter.firstName, "John")
            XCTAssertEqual(mainCharacter.lastName, "Smith")
        case .failure: XCTFail("Expected result to succeed")
        }
    }
}
