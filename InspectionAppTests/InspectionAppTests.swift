//
//  InspectionAppTests.swift
//  InspectionAppTests
//
//  Created by Amisha on 20/06/24.
//

import XCTest
@testable import InspectionApp

final class InspectionAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
    }

    // MARK: - EMAIL VALIDATION
    func testValidEmail() {
        // Given
        let validEmail = "test@example.com"

        // When
        let isValid = validEmail.isValidEmail

        // Then
        XCTAssertTrue(isValid, "Expected \(validEmail) to be a valid email")
    }

    func testInvalidEmailNoAtSymbol() {
        // Given
        let invalidEmails = ["testexample.com", "test@.com", "test@example", "test@exa!mple.com"]

        for email in invalidEmails {
            // When
            let isValid = email.isValidEmail

            // Then
            XCTAssertFalse(isValid, "Expected \(email) to be an invalid email")
        }
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
